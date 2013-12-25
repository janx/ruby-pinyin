$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ruby-pinyin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ruby-pinyin"
  s.version     = PinYin::VERSION
  s.authors     = ["Jan Xie"]
  s.email       = ["jan.h.xie@gmail.com"]
  s.homepage    = "https://github.com/janx/ruby-pinyin"
  s.summary     = "Convert Chinese characters into pinyin."
  s.description = "Pinyin is a romanization system (phonemic notation) of Chinese characters, this gem helps you to convert Chinese characters into pinyin form."
  s.license     = 'MIT'

  s.files = Dir["{lib}/**/*"] + ["LICENSE", "README.markdown"]

  s.add_runtime_dependency('rmmseg-cpp', ['~> 0.2.9'])
end
