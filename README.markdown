# ruby-pinyin: 支持多音字的汉字转拼音工具
[![Build Status](https://travis-ci.org/janx/ruby-pinyin.svg?branch=master)](https://travis-ci.org/janx/ruby-pinyin)

ruby-pinyin: zhī chí duō yīn zì de hàn zì zhuǎn pīn yīn gōng jù

ruby-pinyin可以把汉字转化为对应的拼音，并能够较好的处理多音字的情况。比如：

        PinYin.of_string('南京市长江大桥', :ascii)

能够正确的将“长”转为"chang2", 而不是"zhang3".

## Features

* 支持多音字
* 使用最新的UNICODE数据(6.3.0 published at 2013/02/26)
* 能够显示数字或者UNICODE音调(eg: 'cao1', 'cāo')
* 丰富的API
* 支持中英文标点混合字符串
* 中文标点转为英文标点
* 支持自定义读音

## Installation

        gem install ruby-pinyin

或者把ruby-pinyin加入你的Gemfile:

        gem 'ruby-pinyin'

## Examples

        # encoding: utf-8
        require 'ruby-pinyin'

        # return ['jie', 'cao']
        PinYin.of_string('节操')

        # return ['jie2', 'cao1']
        PinYin.of_string('节操', true)
        PinYin.of_string('节操', :ascii)

        # return ["jié", "cāo"]
        PinYin.of_string('节操', :unicode)

        # 正确处理多音字: return ["nán", "jīng", "shì", "cháng", "jiāng", "dà", "qiáo"]
        PinYin.of_string('南京市长江大桥', :unicode)

        # return %w(gan xie party gan xie guo jia)
        PinYin.of_string('感谢party感谢guo jia')

        # return 'gan-xie-party-gan-xie-guo-jia'
        PinYin.permlink('感谢party感谢guo jia')

        # return 'gxpartygxguojia'
        PinYin.abbr('感谢party感谢guo jia')

        # return 'gan xie party, gan xie guo jia!'
        # PinYin.sentence保留标点符号, 同时用对应英文标点代替中文标点
        PinYin.sentence('感谢party， 感谢guo家！')

        # override readings with your own data file
        PinYin.override_files = [File.expand_path('../my.dat', __FILE__)]

更多的例子和参数请参考[测试用例](https://github.com/janx/ruby-pinyin/blob/master/test/pinyin_test.rb)

## 配置 ##

ruby-pinyin有两个PinYin::Backend: `PinYin::Backend::Simple` 以及`PinYin::Backend::MMSeg`. 默认是使用MMSeg backend, 支持多音字识别。如果你不需要多音字识别，或是对内存使用要求很高，或是有其它任何原因想要fallback到Simple backend, 可以如下配置：

```ruby
PinYin.backend = PinYin::Backend::Simple.new
```

## 自定义发音 ##

通过`PinYin.override_files`可以自定义某些字的发音。自定义的数据以普通文本文件存放，每行定义一个字的发音，以ASCII空格将汉字的unicode编码和拼音隔开。格式可参考[lib/ruby-pinyin/data/Mandarin.dat](https://github.com/janx/ruby-pinyin/blob/master/lib/ruby-pinyin/data/Mandarin.dat)文件。

## 欢迎任何帮助 ##

如果你喜欢这个项目，请通过(不限)以下方式帮助她!

* 各种使用
* 各种宣传
* 各种报告bug, 提供建议  (github issue tracker)
* 各种修bug, 实现feature (github pull request)

## LICENSE ##

[BSD LICENSE](https://github.com/janx/ruby-pinyin/blob/master/LICENSE)

ruby-pinyin中的拼音数据由作者整理自互联网，你可以在ruby-pinyin之外的地方任意使用，但是请注明数据来自ruby-pinyin :-)

## Contributors ##

* [Martin91](https://github.com/Martin91)
* [jaxi](https://github.com/jaxi)
* [jiangxin](https://github.com/jiangxin)
* [forresty](https://github.com/forresty)
* [pzpz](https://github.com/pzpz)
* [Eric Guo](https://github.com/Eric-Guo)
