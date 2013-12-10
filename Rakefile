require 'rake/testtask'

Rake::TestTask.new('test') do |t|
  t.libs << 'test'
  t.pattern = '**/*_test.rb'
  t.verbose = true
end

task :default => :test
