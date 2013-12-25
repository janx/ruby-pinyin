require 'rmmseg'

module PinYin
  module Backend
    class MMSeg

      def initialize
        @simple = Simple.new

        RMMSeg::Dictionary.dictionaries.delete_if {|(type, path)| type == :words}
        RMMSeg::Dictionary.dictionaries.push [:words, File.expand_path('../words.dic', __FILE__)]
        RMMSeg::Dictionary.load_dictionaries
      end

      def romanize(str, tone=nil, include_punctuations=false)
        return [] unless str && str.length > 0

        words = segment str

        base = @simple.romanize(str, tone, include_punctuations)
        patch = words.map {|w| format(w, tone) }.flatten

        apply base, patch
      end

      def segment(str)
        algor = RMMSeg::Algorithm.new str

        words = []
        while token = algor.next_token
          words.push token.text.force_encoding("UTF-8")
        end
        words
      end

      private

      def dictionary
        return @dict if @dict

        @dict = {}
        src = File.expand_path('../words.dat', __FILE__)
        File.readlines(src).map do |line|
          word, ascii, unicode = line.strip.split(',')
          @dict[word] = [ascii, unicode]
        end

        @dict
      end

      def get_pinyin(word, tone)
        readings = dictionary[word]
        return unless readings

        case tone
        when :unicode
          readings[1]
        when :ascii, true
          readings[0]
        else
          readings[0].gsub(/\d/, '')
        end
      end

      def format(word, tone)
        pinyin = get_pinyin(word, tone)
        return pinyin.split(' ') if pinyin

        #如果是个英文单词，直接返回，否则返回与词等长的nil数组
        word =~ /^[_0-9a-zA-Z\s]*$/ ? word : [nil]*word.size
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
