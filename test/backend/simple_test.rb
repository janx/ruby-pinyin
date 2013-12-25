require 'helper'

class SimpleBackendTest < Minitest::Test

  def test_override_files
    backend = PinYin::Backend::Simple.new
    assert_equal ['guang3'], backend.romanize('广', :ascii)

    backend = PinYin::Backend::Simple.new [File.expand_path('../../fixtures/my.dat', __FILE__)]
    assert_equal ['yan3'], backend.romanize('广', :ascii)
  end

end
