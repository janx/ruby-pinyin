require 'ruby-pinyin/value'

module PinYin
  class <<self

    def override_files
      @override_files || []
    end

    def override_files=(files)
      @override_files = files
      @codes = nil
    end

    def codes
      return @codes if @codes

      @codes = {}
      src = File.expand_path('../ruby-pinyin/Mandarin.dat', __FILE__)
      override_files.unshift(src).each do |file|
        load_codes_from(file)
      end
      @codes
    end

    def of_string(str, tone=nil, include_punctuations=false)
      res = []
      return res unless str && !str.empty?

      str.unpack('U*').each_with_index do |t,idx|
        code = sprintf('%x',t).upcase
        readings = codes[code]

        if readings
          res << Value.new(format(readings, tone), false)
        else
          val = [t].pack('U*')
          if val =~ /^[_0-9a-zA-Z\s]*$/ # 复原，去除特殊字符,如全角符号等。
            (res.last && res.last.english? ? res.last : res) << Value.new(val, true) # 如果上一个字符也是非中文则与之合并
          elsif include_punctuations
            (res.last ? res.last : res) << Value.new(val, false)
          end
        end
      end

      res.map {|phrase| phrase.split(/\s+/)}.flatten
    end

    def permlink(str, sep='-')
      of_string(str).join(sep)
    end

    def abbr(str, except_lead=false, except_english=true)
      result = ""
      of_string(str).each_with_index do |word, i|
        w = (except_lead && i == 0) || (except_english && word.english?) ? word : word[0]
        result << w
      end
      result
    end

    def sentence(str, tone=nil)
      of_string(str, tone, true).join(' ')
    end

    private

    def load_codes_from(file)
      File.readlines(file).map do |line|
        code, ascii, unicode = line.split(/\s+/)
        @codes[code] ||= []
        @codes[code][0] = ascii if ascii
        @codes[code][1] = unicode if unicode
      end
    end

    def format(readings, tone)
      case tone
      when :unicode
        readings[1]
      when :ascii, true
        readings[0]
      else
        readings[0].gsub(/\d/,'')
      end
    end
  end
end
