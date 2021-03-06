require 'inifile'
require 'optparse'
require 'rubygems' unless defined?(Gem)

module IniSearch
  class MissingIniFile < StandardError; end
  class MissingSearchKey < StandardError; end
  class FailureIniDataSet < StandardError; end

  $:.unshift(File.dirname(__FILE__))
  %w( helper cli searcher ).each do |lib|
    begin
      require "ini_search/#{lib}"
    rescue LoadError
       require File.expand_path(File.join(File.dirname(__FILE__), 'ini_search', lib))
    end
  end

end



