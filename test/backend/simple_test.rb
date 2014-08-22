# -*- coding: utf-8 -*-

require 'helper'

class SimpleBackendTest < Minitest::Test

  def setup
    @backend = PinYin::Backend::Simple.new
  end

  def test_override_files
    assert_equal ['guang3'], @backend.romanize('广', :ascii)

    backend = PinYin::Backend::Simple.new [File.expand_path('../../fixtures/my.dat', __FILE__)]
    assert_equal ['yan3'], backend.romanize('广', :ascii)
  end

  def test_romanize
    assert_equal ["nan", "jing", "shi", "zhang", "jiang", "da", "qiao"], @backend.romanize("南京市长江大桥")
  end

  def test_romanize_as_unicode
    assert_equal ["nán", "jīng", "shì", "zhǎng", "jiāng", "dà", "qiáo"], @backend.romanize("南京市长江大桥", :unicode)
  end

  def test_romanize_as_ascii
    assert_equal ["nan2", "jing1", "shi4", "zhang3", "jiang1", "da4", "qiao2"], @backend.romanize("南京市长江大桥", :ascii)
  end

  def test_romanize_with_punctuations
    assert_equal ["ni", "hao,", "shi", "jie!"], @backend.romanize("你好, 世界!", nil, true)
  end

  def test_romanize_without_punctuations
    assert_equal ["ni", "hao", "shi", "jie"], @backend.romanize("你好, 世界!", nil, false)
  end

  def test_romanize_numbers_and_space
    assert_equal ['rui', 'dian', '2009'], @backend.romanize("瑞典 2009")
  end

end
