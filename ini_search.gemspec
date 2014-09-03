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

  s.files = `git ls-files`.split("\n")
  s.homepage    = "http://github.com/shadowbq/#{name}"


  s.summary = s.description
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.executables = ["ini-search"]

  s.required_rubygems_version = ">= 1.8.1"

  s.add_development_dependency 'bundler', '~> 1.0'

  s.add_runtime_dependency 'inifile'

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

