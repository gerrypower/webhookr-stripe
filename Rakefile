
# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

if RUBY_VERSION >= '1.9'
  begin
    gem 'psych'
  rescue Exception => e
    # it's okay, fall back on the bundled psych
  end
end

$:.push 'lib'

version = Webhookr::Stripe::VERSION

desc 'Test Webhookr Stripe'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_tests.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.main = 'README.md'
  t.title = "Webhookr Stripe #{version}"
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.md', 'MIT-LICENSE', 'lib/**/*.rb')
end

task :default => :test