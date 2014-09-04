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

end