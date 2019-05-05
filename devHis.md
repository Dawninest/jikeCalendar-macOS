### 2019-5-5 macOS即刻锁屏壁纸 重构

好吧,五一我其实没去维护我的小程序,毕竟忙(着玩),

五一收假第一天,使用Objective-C重构了saver项目,现在应该能支持更多低版本的系统了

现在无需使用dock工具登录就可以拿到即刻的数据了,感谢 即友 @nondanee 的 [数据接口](https://gitlab.com/nondanee/jike-daily-card-api) 

额外的:

​	果然在Xcode建立saver项目,不提供Swift语言的选择是有原因的啊,感觉用OC写的构建和运气起来速度都会快不少,希望下个大版本macOS和iOS共通后能对macOS开发有所改善吧.

つづく

### 2019-4-28 macOS即刻锁屏壁纸 缺陷修复

增加了设置界面显示提示,但是仍然没去开发"屏幕保护程序选项…"的内容

<img src="./readSupport/09.png" width=315 height=230 />

修复了在大屏幕上显示靠上的问题

修复了多显示器显示位置异常的问题

额外的:

​	发现锁屏壁纸发布后,比之前dock版更受欢迎,不得不承认确实"锁屏壁纸"这个使用场景更适合"即刻日历"这个功能点, 毕竟dock栏就是需要放那种经常需要的随手就点的工具栏(正经脸),我这个一天点一下这种还是差点意思,

后续考虑在  "屏幕保护程序选项…" 中加上扫码登录相关功能,再进一步将 saver版 从 dock版 中独立出来,

五一打算去维护我的微信小程序"你在微信看番么",此项目的开发和维护暂且搁浅一下

### 2019-4-22 macOS即刻锁屏壁纸 完成

还有有必要来解释一下为啥鸽了这么久,

三件事: 追姑娘,拼乐高,厦门出差

恭喜我4.21号脱单了,然后一高兴,4.22号就把这个做好了

可以早做完,但是没必要(懒)

这次的 即刻日历dock栏工具和锁屏壁纸 初版就告一段落了

不确定以后还会不会再拓展这个项目,

说不定有其他不错的想法再开新坑,

也不知道谈对象后还有没有精力再像这样兴趣使然地来做个愉悦自己的东西玩,

不过我还是要在最后加上 つづく . 吾之道永不终止

### 2019-4-8 即刻日历 macOS 锁屏壁纸 开坑

类似于 Fliqlo 锁屏显示时间,打算以此为基础将即刻日历搬上屏幕保护程序

技术关键词:  screen saver

上传基础 demo, 数据与 dock 栏联动



### 2019-4-6 接入扫码登录及初版定版

在github 上与 即友 **nondanee** 一番讨论接口调整之后,我在 4月5号晚上吃火锅的时候想通了,还是决定接入扫码登录功能,毕竟这样无需自己整个后台支持,而且应用功能相对稳定

一顿键盘"哒哒哒~"之后,完成了初代版

上图

<img src="./readSupport/07.jpg" width=154 height=121 />

<img src="./readSupport/04.jpg" width=300 height=300 />

<img src="./readSupport/05.jpg" width=300 height=300 />

甚至适配了系统暗黑模式! [吾,响应了那来自黑暗的力量啊]

<img src="./readSupport/06.jpg" width=300 height=300 />

会保存一个扫码拿到的请求数据token到 /用户名/文稿/j2k.txt 中

大约 15 天后token过期需要重新扫码

### 2019-4-4 logo及接口调整计划

定版了logo,现在大约这个样子

<img src="./readSupport/03.jpg" width=300 height=300 />

想了很久,还是觉得接受不了看个日历还得打开即刻App扫码登录,琢磨了一下,还是打算自己整个地方存放自己的验证(并定期更新),具体实现及细节还得调整

### 2019-4-3 logo

初版logo大约这个样子

<img src="./readSupport/02.jpg" width=200 height=200 />

想当年我大三出去找实习的时候,还是一名UI,但是不信那些🐶开发说我的设计做不出来,于是便转开发了.(其实是还是因为设计不符合开发规范)

写这个md的时候,忽然觉得这个logo怎么这么丑,嫌弃,回头有时间再整一版吧

### 2019-4-2 界面

基本功能完成,界面如图

![](./readSupport/01.jpg)

### 2019-4-1 - 第三次尝试

今儿改完了公司项目的BUG之后,还是琢磨这个数据问题,真让人头大,于是琢磨着去看看即友们是怎么做的,参考了大佬的 [Jike-Metro](https://github.com/Sorosliu1029/Jike-Metro) 的.py源码和 [jike-meow-2](https://github.com/coder-ysj/jike-meow-2) 的Vue项目源码,(哇,我作为一个iOS开发,又能看懂py又能看懂js也是很厉害呀),发现了我之前的一个理解误区, 这个 

```
https://app.jike.ruguoapp.com/1.0/app_auth_tokens.refresh
```

这个刷新jwt的接口,其实只需要  x-jike-refresh-token 这个就能拿到我所需的用于数据请求的 jwt 了,

然后在web版扫描二维码登录之后会返回一个

```
{
  token: xxx,
  x-jike-access-token: xxx,
  x-jike-refresh-token: xxx,
}
```

然后用这里的 x-jike-refresh-token 去调 刷新jwt接口,

貌似 这个 x-jike-refresh-token 是不会过期的[通过其他渠道拿到的refresh-token会过期],

这样就能拿到的用于请求数据的 jwt 了

------

再简单分析一下这个登录的时候拿到的不会过期的特别refresh-token

在web端扫码登录得到

```
 token: 包含用户ID等信息,过期时间为15天后
 x-jike-access-token: xxx, 刚拿到时可用于请求数据,但是还是20-30分钟后过期了
 x-jike-refresh-token: xxx, 预计应该是一个有效期15天的的刷新jwt,解析该jwt仅仅能拿到申请时间,是否会过期还需要后续观察
```



综上所诉,现在我要能正确拿到数据有两种做法:

1.让用户每隔15天扫码登录一次,

2.我在代码里面使用我自己的账户信息,每隔15天更新一次

做法一的话,我比较省心,而且至少能保证一直能用,但是有违我想要做一款简单易用的dock工具的初衷,

做法二的话,我需要定期把自己的即刻账号的jwt更新到网络上,然后假设某一天忘了更新,会导致工具短暂地用不了.

### 2019-3-28 - 第二次尝试

改完了今天的BUG之后,忽然想到,即刻不是有网页版么,网页版的获取JWT和更新JWT要更好观察一些,不如搞一下

即刻网页版 - 登录

⌘⌥I - 开启页面检查器

拿到 JWT 

多次请求拼接尝试后,试出了正确的

```
https://app.jike.ruguoapp.com/1.0/dailyCards/list?x-jike-access-token=xxx
```

岂可修,但是这个 JWT 还是会更新的,周期大约 20 - 30 mins 左右,

查看网页的js文件,功力不够,没法从被混淆的代码里发现什么线索,



在这儿停顿! 	- 卢西奥(overwatch)



能在网页版上找到线索也算是有了思路,

后续打算在自己服务器上去拿 即刻网页版 的 jwt ,来维持jwt的有效

### 2019.3.27 - 第一次尝试

首先是数据接口

毕竟还是没有脸皮厚到去发邮件问,所以自己尝试抓包找线索咯

尝试用App抓包该数据的接口

```
url: https://app.jike.ruguoapp.com/1.0/dailyCards/list?coordsys=wgs84&date=2019-03-27
method: GET
headers: {
    x-jike-device-id: 'xxx',
    x-jike-access-token: 'xxx',
}
```

发现其 x-jike-access-token 是用于请求的关键JWT,但是十分钟更新一次

遂找到其更新 JWT 接口

```
url: https://app.jike.ruguoapp.com/1.0/app_auth_tokens.refresh
method: POST
headers: {	
	// 10 mins 刷新一次
	x-jike-access-token(新): ‘xxx’
	x-jike-refresh-token(用于刷新请求的token): ‘xxx’
}
```

解析 x-jike-refresh-token 这个JWT,得到

```
{
  "data": "2jVubuRnQRBvB375nOoxpBmV/CiYQ0qmOxkzXhraq0WbrC59W1Rma1V09102K3/RVtMB58421l227Nz4FpSa3BtHHYnhah79+d+sR4rdfQecMigIoSHz7NFksd7IPdBS1XhnO9UYGkhJd/xBbl1aPDIJPm0ysvjf53rrf9JM4z0rtD1HEU0lndLFuCFwQIamAxPxiSUQVbIo25xktGNw9Fcsex82TsxiXyu0d1CIHOIzgqApSI2ArM3oAVmXSPWlFhoFF3Ksg46PnJpJmR7Nqv93uXJwODo7+57Womr42/smDp5l6HZ0DLc5diWz5ttWIrUBcxSP9ZTgBPZk55Q3C5Lml4OpSxtTlJv2dAtvF8Tr8gBTKh+cr3axy+9qns3MMKyu4bx9I2Yj/CEm3Ll4uw==",
  "v": 3,
  "iv": "S9QY4Sh7Q6zKBRJ/0XCGWw==",
  "iat": 1553673189.169
}
```

可以看出 iat 是时间戳,其他代码疑似 RSA 加密

