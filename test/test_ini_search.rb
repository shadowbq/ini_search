# encoding: UTF-8

libpath = File.expand_path '../../lib', __FILE__
require File.join(libpath, 'ini_search')
require 'fileutils'
require 'test/unit'


class TestIniSearch < Test::Unit::TestCase

  def setup
    @ini_file = IniFile.new(:filename => 'test/data/good.ini')
    FileUtils.cp    "test/data/good.ini", "test/data/tmp.ini"
  end

  def teardown
    FileUtils.rm_rf "test/data/tmp.ini"
  end

  def test_class_load
    ini_file = IniFile.load 'test/data/good.ini'
    assert_instance_of IniFile, ini_file
  end

  def test_has_section_eh
    assert_equal true,  @ini_file.has_section?('section_one')
    assert_equal false, @ini_file.has_section?('section_ten')
  end

  def test_read
    @ini_file.read
    assert_equal 1, @ini_file['section_one']['one']
    assert_equal 2, @ini_file['section_one']['two']
  end

  def test_match_section_regex_1
    out, err = capture_io do 
      IniSearch::Searcher.new(obj_inifile: @ini_file, key: 'one',  find_existance: true)
    end
    assert_match "section_one\nsection_one:one", out 
  end
  

  def test_match_section_regex_2
    out, err = capture_io do 
      IniSearch::Searcher.new(obj_inifile: @ini_file, key: 'four',  sect_regexp: Regexp.new('secti.*'))
    end
    assert_match "section three:four", out   
  end

  def test_match_section_regex_3
    out, err = capture_io do 
      IniSearch::Searcher.new(obj_inifile: @ini_file, key: 'three',  sect_regexp: Regexp.new('section_.*'))
    end
    assert_match "", out   
  end

    def test_match_section_regex_4
    out, err = capture_io do 
      IniSearch::Searcher.new(obj_inifile: @ini_file, key: 'five',  sect_regexp: Regexp.new('section_.*'))
    end
    assert_match "", out   
  end

end
