require 'inifile'
require 'optparse'
require 'rubygems' unless defined?(Gem)

module IniSearch
  $:.unshift(File.dirname(__FILE__))
  %( cli ).each do |lib|
    begin
      require "ini_search/#{lib}"
    rescue LoadError
       require File.expand_path(File.join(File.dirname(__FILE__), 'ini_search', lib))
    end
  end     
end



