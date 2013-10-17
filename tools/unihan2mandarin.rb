#!/usr/bin/env ruby
# encoding: UTF-8

input = ARGV[0] || File.expand_path('../unihan.txt', __FILE__)
exceptions_input = File.expand_path('../exceptions.txt', __FILE__)
output = ARGV[1] || File.expand_path('../../lib/ruby-pinyin/Mandarin.dat', __FILE__)
count = 0

ASCII_TABLE = {
  'ā' => ['a', 1], 'ē' => ['e', 1], 'ī' => ['i', 1], 'ō' => ['o', 1], 'ū' => ['u', 1], 'ǖ' => ['v', 1],
  'á' => ['a', 2], 'é' => ['e', 2], 'í' => ['i', 2], 'ó' => ['o', 2], 'ú' => ['u', 2], 'ǘ' => ['v', 2],
  'ǎ' => ['a', 3], 'ě' => ['e', 3], 'ǐ' => ['i', 3], 'ǒ' => ['o', 3], 'ǔ' => ['u', 3], 'ǚ' => ['v', 3],
  'à' => ['a', 4], 'è' => ['e', 4], 'ì' => ['i', 4], 'ò' => ['o', 4], 'ù' => ['u', 4], 'ǜ' => ['v', 4]
}

def to_ascii(reading)
  reading = reading.dup

  ASCII_TABLE.each do |char, (ascii, tone)|
    if reading.tr!(char, ascii)
      return reading.concat(tone.to_s)
    end
  end

  reading
end

exceptions = {}
File.readlines(exceptions_input).each do |l|
  code, ascii_reading, reading, _ = l.split(/\s+/)
  exceptions[code] = [ascii_reading, reading]
end

File.open(output, 'w') do |out|
  File.readlines(input).each do |line|
    next if line =~ /^#/

    code, type, reading = line.split(/\s+/)
    if 'kMandarin' == type
      count += 1
      code = code[2..-1]
      if e = exceptions[code]
        out.printf "%s %s %s\n", code, e[0], e[1]
      else
        out.printf "%s %s %s\n", code, to_ascii(reading), reading
      end
    end
  end
end

puts "#{count} mandarin readings saved in #{output}"
