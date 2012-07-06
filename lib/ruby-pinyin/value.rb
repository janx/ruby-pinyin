module PinYin
  class Value < String
    attr_accessor :english
    alias :english? :english

    def initialize(str, english=true)
      super(str)
      self.english = english
    end

    def split(*args)
      result = super
      result.map {|str| self.class.new(str, english)}
    end
  end
end
