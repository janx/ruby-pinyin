#!/usr/bin/env ruby
# encoding: UTF-8

PUNCTUATIONS = {
  '，' => ',',
  '。' => '.',
  '！' => '!',
  '？' => '?',
  '：' => ':',
  '“' => '"',
  '”' => '"',
  '‘' => "'",
  '’' => "'"
}

def char_to_hex(c)
  c.ord.to_s(16).upcase
end

output = ARGV[1] || File.expand_path('../../lib/ruby-pinyin/data/Punctuations.dat', __FILE__)

File.open(output, 'w') do |out|
  PUNCTUATIONS.each do |k, v|
    out.printf "%s %s\n", char_to_hex(k), char_to_hex(v)
  end
end

puts "Successfully generated punctuations at #{output}."

