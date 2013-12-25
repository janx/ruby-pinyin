require 'helper'

class PinYinTest < Minitest::Test
  def test_get_pinyin_of_multiple_pronunciation_character
    assert_equal ['hao3'], PinYin.of_string('好', true) # code 597D, value hao3
  end

  def test_get_pinyin_of_empty_string
    assert_equal [], PinYin.of_string('')
    assert_equal [], PinYin.of_string(nil)
  end

  def test_get_pinyin_of_chinese_string
    assert_equal ['jie', 'cao'], PinYin.of_string('节操')
  end

  def test_get_pinyin_of_chinese_string_with_tone
    assert_equal ['jie2', 'cao1'], PinYin.of_string('节操', true)
  end

  def test_get_pinyin_of_chinese_string_with_ascii_tone
    assert_equal ['jie2', 'cao1'], PinYin.of_string('节操', :ascii)
  end

  def test_get_pinyin_of_chinese_string_with_unicode_tone
    assert_equal ["jié", "cāo"], PinYin.of_string('节操', :unicode)
  end

  def test_get_pinyin_of_english_phrase
    assert_equal %w(And the winner is), PinYin.of_string('And the winner is ...')
  end

  def test_get_pinyin_of_mixed_string
    pinyin = PinYin.of_string '感谢party感谢guo jia'
    assert_equal %w(gan xie party gan xie guo jia), pinyin
    assert_equal true, pinyin.all? {|word| word.class == PinYin::Value}
  end

  def test_permlink
    assert_equal 'gan-xie-party-gan-xie-guo-jia', PinYin.permlink('感谢party感谢guo jia')
  end

  def test_permlink_with_customized_seperator
    assert_equal 'gan+xie+party+gan+xie+guo+jia', PinYin.permlink('感谢party感谢guo jia', '+')
  end

  def test_abbr
    assert_equal 'gxpartygxguojia', PinYin.abbr('感谢party感谢guo jia')
  end

  def test_abbr_except_lead
    assert_equal 'ganxpartygxguojia', PinYin.abbr('感谢party感谢guo jia', true)
  end

  def test_abbr_with_english
    assert_equal 'gxpgxgj', PinYin.abbr('感谢party感谢guo jia', false, false)
  end

  def test_get_pinyin_sentence
    assert_equal 'gan xie party, gan xie guo jia!', PinYin.sentence('感谢party, 感谢guo家!')
  end

  def test_get_pinyin_sentence_with_unicode_punctuation
    assert_equal 'hello, world', PinYin.sentence('hello， world')
  end

  def test_get_pinyin_sentence_with_ascii_tone
    assert_equal 'gan3 xie4 party, gan3 xie4 guo jia1!', PinYin.sentence('感谢party, 感谢guo家!', :ascii)
  end

  def test_get_pinyin_sentence_with_unicode_tone
    assert_equal 'gǎn xiè party, gǎn xiè guo jiā!', PinYin.sentence('感谢party, 感谢guo家!', :unicode)
  end

end
