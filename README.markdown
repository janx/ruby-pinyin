# ruby-pinyin: 将中国汉字转化为对应的拼音

这个工具最初是[LeoChen工作](http://www.upulife.com/leo/?p=260)的包装，经过一段时间的修改，修复了其中的bug, 增加了单元测试并且重构了大部分代码.

Example:

        # encoding: utf-8
        require 'ruby-pinyin'

        # return ['JIE', 'CAO']
        PinYin.of_string('节操')

        # return ['JIE2', 'CAO1']
        PinYin.of_string('节操', true)

        # return %w(GAN XIE party GAN XIE guo jia)
        PinYin.of_string('感谢party感谢guo jia')

        # return 'gan-xie-party-gan-xie-guo-jia'
        PinYin.permlink('感谢party感谢guo jia')

        # return 'gxpartygxguojia'
        PinYin.abbr('感谢party感谢guo jia')

        # return 'gan xie party, gan xie guo jia!'
        # PinYin.sentence保留标点符号
        PinYin.sentence('感谢party, 感谢guo家!')

更多的例子和参数请参考[测试用例](https://github.com/janx/ruby-pinyin/blob/master/test/pinyin_test.rb)

## 测试平台 ##

运行测试: `ruby -Ilib test/pinyin_test.rb`

已在如下平台测试:

* MRI 1.9.3-p327
* MRI 1.9.3-p125
* MRI 1.9.2-p290
* MRI 1.8.7-p358
* Ruby Enterprise Edition 1.8.7-2012.02

## TODO ##

* 支持utf-8以外的编码
* 为多音字提供api

## 欢迎任何帮助 ##

如果你喜欢这个项目，请通过(不限)以下方式帮助她!

* 各种使用
* 各种宣传
* 各种报告bug, 提供建议  (github issue tracker)
* 各种修bug, 实现feature (github pull request)

## Contributors ##

* [Martin91](https://github.com/Martin91)

## Thanks ##

* [LeoChen的脚本](http://www.upulife.com/leo/?p=260)
* [Lingua::Han::PinYin](http://www.fayland.org/journal/Han-PinYin.html)
