# -*- coding: utf-8 -*-

require 'helper'

class MMSegBackendTest < MiniTest::Unit::TestCase

  Backend = PinYin::Backend::MMSeg.new

  def test_segment
    assert_equal ["南京市", "长江", "大桥"], Backend.segment("南京市长江大桥")
  end

  def test_romanize
    assert_equal ["nan", "jing", "shi", "chang", "jiang", "da", "qiao"], Backend.romanize("南京市长江大桥")
  end

  def test_romanize_as_unicode
    assert_equal ["nán", "jīng", "shì", "cháng", "jiāng", "dà", "qiáo"], Backend.romanize("南京市长江大桥", :unicode)
  end

  def test_romanize_as_ascii
    assert_equal ["nan2", "jing1", "shi4", "chang2", "jiang1", "da4", "qiao2"], Backend.romanize("南京市长江大桥", :ascii)
  end

  def test_romanize_with_punctuations
    assert_equal ["fei", "ci", "gan", "xie", "party,", "gan", "xie", "guo", "jia!"], Backend.romanize('非词感谢party, 感谢guo家!', nil, true)
  end

  def test_romanize_without_punctuations
    assert_equal ["fei", "ci", "gan", "xie", "party", "gan", "xie", "guo", "jia"], Backend.romanize('非词感谢party, 感谢guo家!', nil, false)
  end

end
