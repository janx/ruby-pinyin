# -*- coding: utf-8 -*-

require 'rmmseg'

module PinYin
  module Backend
    class MMSeg

      def initialize(override_files=[])
        @simple = Simple.new override_files

        RMMSeg::Dictionary.dictionaries.delete_if {|(type, path)| type == :words}
        RMMSeg::Dictionary.dictionaries.push [:words, File.expand_path('../../data/words.dic', __FILE__)]
        RMMSeg::Dictionary.load_dictionaries
      end

      def romanize(str, tone=nil, include_punctuations=false)
        return [] unless str && str.length > 0

        words = segment str

        base = @simple.romanize(str, tone, include_punctuations)
        patch = words.map {|w| format(w, tone) }.flatten

        if base.size != patch.size
          base.compact!
          patch.compact!
        end

        apply base, patch
      end

      def segment(str)
        algor = RMMSeg::Algorithm.new str

        words = []
        while token = algor.next_token
          s = token.text.force_encoding("UTF-8")
          words.push(s) unless s =~ Punctuation.chinese_regexp
        end
        words
      end

      private

      def dictionary
        return @dict if @dict

        @dict = {}
        src = File.expand_path('../../data/words.dat', __FILE__)
        File.readlines(src).map do |line|
          word, unicode = line.strip.split(',')
          @dict[word] = unicode
        end

        @dict
      end

      def get_pinyin(word, tone)
        return unless dictionary[word]

        case tone
        when :unicode
          dictionary[word]
        when :ascii, true
          to_ascii dictionary[word], true
        else
          to_ascii dictionary[word], false
        end
      end

      def to_ascii(word, with_tone)
        word.split(' ').map do |reading|
          PinYin::Util.to_ascii(reading, with_tone)
        end.join(' ')
      end

      def format(word, tone)
        pinyin = get_pinyin(word, tone)
        return pinyin.split(' ') if pinyin

        #如果是个英文单词，直接返回，否则返回与词等长的nil数组
        if word =~ /^[_0-9a-zA-Z\s]*$/
          word
        elsif word.respond_to? :force_encoding
          # word has been encoded in UTF-8 already
          [nil] * word.size
        else
          # For ruby 1.8, there is no native utf-8 support
          [nil] * word.unpack('U*').size
        end
      end

      def apply(base, patch)
        result = []
        base.each_with_index do |char, i|
          if patch[i].nil?
            result.push char
          elsif char =~ Punctuation.regexp
            result.push Value.new("#{patch[i]}#{$1}", char.english?)
          else
            result.push Value.new(patch[i], char.english?)
          end
        end
        result
      end

    end
  end
end
