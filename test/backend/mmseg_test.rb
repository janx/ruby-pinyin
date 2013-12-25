require 'helper'

class MMSegBackendTest < Minitest::Test

  def setup
    @backend = PinYin::Backend::MMSeg.new
  end

  def test_segment
    assert_equal ["南京市", "长江", "大桥"], @backend.segment("南京市长江大桥")
  end

  def test_romanize
    assert_equal "nán jīng shì cháng jiāng dà qiáo", @backend.romanize("南京市长江大桥", :unicode)
  end

end
