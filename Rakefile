begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MidasGenie'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'



Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# Use find_all_by_name instead of find_by_name as find_all_by_name will return pre-release versions
gem_specification = Gem::Specification.find_all_by_name('metasploit-yard').first

Dir[File.join(gem_specification.gem_dir, 'lib', 'tasks', '**', '*.rake')].each do |rake|
  load rake
end
