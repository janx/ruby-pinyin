#!/usr/bin/env ruby
# encoding: UTF-8

exceptions_input = File.expand_path('../exceptions.txt', __FILE__)
input = ARGV[0] || File.expand_path('../unihan.txt', __FILE__)
output = ARGV[1] || File.expand_path('../../lib/ruby-pinyin/data/Mandarin.dat', __FILE__)

def format(readings)
  readings.scan(/[^,.:()0-9 ]+/)
end

exceptions = {}
File.readlines(exceptions_input).each do |l|
  code, reading, _ = l.split(/\s+/)
  exceptions[code] = reading
end

hash = Hash.new {|h, k| h[k] = {}}
File.readlines(input).each do |line|
  next if line =~ /^#/

  code, type, reading = line.strip.split(/\s+/, 3)
  hash[code][type] = reading
end

count = 0
File.open(output, 'w') do |out|
  hash.each do |code, readings|
    rs = readings['kHanyuPinlu'] || readings['kXHC1983'] || readings['kHanyuPinyin'] || readings['kMandarin']
    if rs.nil?
      puts "Skip non-chinese code: #{readings.inspect}"
    else
      code = code[2..-1]
      array = format rs
      array.unshift(exceptions[code]) if exceptions.has_key?(code)
      out.printf "%s %s\n", code, array.uniq.join(',')
      count += 1
    end
  end
end

puts "#{count} mandarin readings saved in #{output}"
