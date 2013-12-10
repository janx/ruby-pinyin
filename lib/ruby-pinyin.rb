require 'ruby-pinyin/value'
require 'ruby-pinyin/backend'

module PinYin
  class <<self

    attr_accessor :backend

    def of_string(str, tone=nil, include_punctuations=false)
      backend.romanize(str, tone, include_punctuations)
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

  end
end

PinYin.backend = PinYin::Backend::Simple.new
