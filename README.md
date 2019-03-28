# jikeCalendar-macOS-dock
## jikeCalendar in macOS dock

## 即刻黄历macOS Dock版

------

![](./readSupport/00.jpg)

如图所示,是 即刻 的探索页日历

作为 即刻的忠实用户,我琢磨着,要不整个这个放我mac dock栏上呗

于是便打算整一个

------

首先是数据接口

毕竟还是没有脸皮厚到去发邮件问,所以自己场所抓包找线索咯

### 2019.3.27 - 第一次尝试

尝试用App抓包该数据的接口

```
url: https://app.jike.ruguoapp.com/1.0/dailyCards/list?coordsys=wgs84&date=2019-03-27
method: GET
headers: {
    x-jike-device-id: 'xxx',
    x-jike-access-token: 'xxx',
}
```

发现其

```
url: https://app.jike.ruguoapp.com/1.0/dailyCards/list?coordsys=wgs84&date=2019-03-27
method: GET
headers: {
    x-jike-device-id: 'xxx',
    x-jike-access-token: 'xxx',
}
```

发现其

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

解析其 

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



つづく

