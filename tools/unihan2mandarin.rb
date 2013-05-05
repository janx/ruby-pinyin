#!/usr/bin/env ruby

input = ARGV[0] || File.expand_path('../unihan.txt', __FILE__)
output = ARGV[1] || File.expand_path('../../lib/ruby-pinyin/Mandarin.dat', __FILE__)
count = 0

File.open(output, 'w') do |out|
  File.readlines(input).each do |line|
    next if line =~ /^#/

    code, type, reading = line.split(/\s+/)
    if 'kMandarin' == type
      count += 1
      out.printf "%s %s\n", code[2..-1], reading
    end
  end
end

puts "#{count} mandarin readings saved in #{output}"
