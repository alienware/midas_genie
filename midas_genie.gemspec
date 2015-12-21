$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'midas_genie/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'midas_genie'
  s.version     = MidasGenie::VERSION
  s.authors     = ['Tanay Upadhyaya']
  s.email       = ['tanayupadhyaya@gmail.com']
  s.homepage    = 'https://github.com/alienware/midas_genie'
  s.summary     = 'Rails 4 ge(m)nie to create dynamic surveys.'
  s.description = 'TODO: Description of MidasGenie.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.2.5'
  s.add_dependency 'paranoia', '~> 2.0'
  # s.add_dependency 'acts_as_list'
  s.add_dependency 'counter_culture', '~> 0.1.33'
  s.add_dependency 'paranoia_uniqueness_validator', '1.1.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'metasploit-yard', '~> 1.0'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'shoulda-matchers', '~> 2.8'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-its'
  s.add_development_dependency 'rspec-collection_matchers'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'guard-rubocop'
  s.add_development_dependency 'annotate'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'faker'
  s.add_development_dependency 'auto_increment'
  s.add_development_dependency 'byebug'
end
