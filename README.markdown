# ruby-pinyin: 将中国汉字转化为对应的拼音

## Features

* 使用最新的UNICODE数据(6.2.0 published at 2012/08/17)
* 能够显示数字或者UNICODE音调(eg: 'cao1', 'cāo')
* 丰富的API
* 支持中英文标点混合字符串
* 中文标点转为英文标点
* 支持自定义读音

## Installation

        gem install ruby-pinyin

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

## 测试平台 ##

运行测试: `ruby -Ilib test/pinyin_test.rb`

已在如下平台测试:

* MRI 2.0.0-p0
* MRI 1.9.3-p327
* MRI 1.9.3-p125
* MRI 1.9.2-p290
* MRI 1.8.7-p358
* Ruby Enterprise Edition 1.8.7-2012.02
* JRuby-1.7.3

## 欢迎任何帮助 ##

如果你喜欢这个项目，请通过(不限)以下方式帮助她!

* 各种使用
* 各种宣传
* 各种报告bug, 提供建议  (github issue tracker)
* 各种修bug, 实现feature (github pull request)

## LICENSE ##

[MIT-LICENSE](https://github.com/janx/ruby-pinyin/blob/master/MIT-LICENSE)

## Contributors ##

* [Martin91](https://github.com/Martin91)
* [jaxi](https://github.com/jaxi)

## Thanks ##

* [LeoChen的脚本](http://www.upulife.com/leo/?p=260)
* [Lingua::Han::PinYin](http://www.fayland.org/journal/Han-PinYin.html)
