module PinYin
  module Punctuation

    class <<self

      def regexp
        return @regexp if @regexp

        escaped_punctuations = punctuations.values.map {|v| "\\#{[v].pack('H*')}"}.join
        @regexp = Regexp.new "([#{escaped_punctuations}]+)$"
        @regexp
      end

      def chinese_regexp
        @chinese_regexp ||= /([\u3000-\u303F\uFF00-\uFFEF]+)/
      end

      def [](code)
        punctuations[code]
      end

      def include?(code)
        punctuations.has_key?(code)
      end

      def punctuations
        @punctuations ||=
          {}.tap do |punctuations|
            src = File.expand_path('data/Punctuations.dat', __dir__)
            load_from punctuations, src
          end
      end

      def load_from(punctuations, file)
        File.readlines(file).map do |line|
          from, to = line.split(/\s+/)
          punctuations[from] = to
        end
      end

    end

  end
end
