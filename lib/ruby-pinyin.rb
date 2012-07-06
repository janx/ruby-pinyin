require 'ruby-pinyin/value'

module PinYin
  class <<self

    def codes
      return @codes if @codes

      src = File.expand_path('../ruby-pinyin/Mandarin.dat', __FILE__)

      # 不考虑多音字的情况, e.g. ['597D', 'HAO3', 'HAO4']转化成['597D',
      # 'HAO3']再存入codes hash
      @codes = Hash[ File.readlines(src).map {|line| line.split(/\s+/)[0,2]} ]
    end

    def of_string(str, tone=false, include_punctuations=false)
      res = []
      return res unless str && !str.empty?

      str.unpack('U*').each_with_index do |t,idx|
        code = sprintf('%x',t).upcase
        val = codes[code]

        if val
          val = val.gsub(/\d/,'') unless tone
          res << Value.new(val, false)
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

    def permlink(str)
      of_string(str).map(&:downcase).join('-')
    end

    def abbr(str, except_lead=false, except_english=true)
      result = ""
      of_string(str).each_with_index do |word, i|
        w = (except_lead && i == 0) || (except_english && word.english?) ? word : word[0]
        result << w
      end
      result.downcase
    end

    def sentence(str, tone=false)
      of_string(str, tone, true).map(&:downcase).join(' ')
    end

  end
end
