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
        words = segment str
        words.map {|w| dictionary[w] || @simple.romanize(w, tone, include_punctuations)}.join(' ')
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
          word, pinyin = line.strip.split(/\s+/, 2)
          @dict[word] = pinyin
        end

        @dict
      end

    end
  end
end
