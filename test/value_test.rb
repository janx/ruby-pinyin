require 'helper'

class ValueTest < Minitest::Test

  def test_value_initialize
    v = PinYin::Value.new('hello')
    assert_equal 'hello', v
    assert_equal true, v.english?
  end

  def test_value_split
    ary = PinYin::Value.new('hello world').split(/\s/)
    assert_equal PinYin::Value, ary[0].class
  end

end
