$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require File.expand_path('../lib/ini_search/version', __FILE__)
name = "IniSearch"

Gem::Specification.new do |s|
  s.name               = name
  s.version            = IniSearch::VERSION
 
  s.authors = ["shadowbq"]
  s.date = %q{2014-08-01}
  s.description = %q{A simple ini search gem}
  s.email = %q{shadowbq@gmail.com}

  s.homepage    = "http://github.com/shadowbq/#{name}"
  s.summary = s.description
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  

  s.files = `git ls-files`.split("\n")
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  


  s.required_rubygems_version = ">= 1.8.1"

  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_runtime_dependency 'inifile'


end

