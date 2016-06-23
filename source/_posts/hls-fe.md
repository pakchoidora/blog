title: 初识 HLS 协议
categeries:
  - Casual
  - HLS
  - M3U8
  - HTTP
date: 2016-06-21 17:16:53
figure:
description:
tags:
---


有一天偶然从公司 KM 的推送中看到 HLS 协议这么一个东西, 觉得有意思而且之前在上一家公司时, 也听闻这么一个技术, 但是一直没有机会接触, 于是乎找了找资料来了解下, 本文不准备讨论实现及应用, 只做简单了解.

# HLS

HLS(http live stream), Apple 公司于2009年提出的基于 HTTP 协议的流媒体协议.
支持度: iOS、MacOSX 及 Apple TV 原生支持; Android 3.0+ 支持.

它的传输内容包括两部份, 一是 M3U8 描述文件, 而是 TS 媒体文件.

# 流媒体协议

+ RTP/RTCP
+ RTMP \(各大直播平台常用的, 在 Flash 及 AIR 中有很好的支持\)
+ DASH
+ HLS

# HLS 特点

+ 支持直播和点播实现
+ 支持用户拖放、回放等操作
+ 支持点播资源的加密和鉴权\(借助HTTPS\)
+ 支持流的智能实时切换\(针对网络带宽、设备\)
+ ...

# HLS 优缺点

## HLS 优点

+ 基于 HTTP
+ 可充分利用 CDN
+ 广播电视标准成熟, 快速进入产业链
+ 普通 Web 服务器即可
+ 自适应码率
+ 广泛的 iOS 平台支持

## HLS 缺点

+ 延迟较高
+ PC 平台 HTML5 支持不够成熟, 需要第三方 \(比如: Flash 播放\)
+ MPEG2-TS 文件协议较复杂
+ 不适合做交互式语音应用

# Web 中如何使用

```
<video controls>
    <source src="example.m3u8"></source>
</video>
```

或者

```
<video src="example.m3u8" controls></video>
```

# M3U8

M3U8 是 M3U 的 UTF8 编码版本, M3U 是一种列表文件, 只提供一些描述信息.

M3U 文件中可以包含多个 tag, 每个 tag 的功能和属性如下

## M3U8 常见 Tag

__\#EXTM3U__    
每个 M3U 文件第一行必须是这个 tag, 请标示作用

__\#EXT-X-MEDIA-SEQUENCE: &lt;sequence&gt;__    
每一个media URI 在 PlayList 中只有唯一的序号, 相邻之间序号 +1, 一个 media URI 并不是必须要包含的, 如果没有, 默认为 0

__\#EXTINF: &lt;duration&gt; [, &lt;title&gt;]__    
duration 指定每个媒体段(ts)的持续时间(秒), 仅对其后面的URI有效, title 是下载资源的 url

__\#EXT-X-TARGETDURATION: &lt;duration&gt;__    
指定最大的媒体段时间长\(秒\). 所以#EXTINF中指定的时间长度必须小于或是等于这个最大值. 这个 tag 在整个 PlayList 文件中只能出现一次 \(在嵌套的情况下, 一般有真正 TS url 的 m3u8 才会出现该 tag)

__\#EXT-X-KEY: &lt;attribute-list&gt;__    
表示怎么对 media segments 进行解码. 其作用范围是下次该 tag 出现前的所有 media URI, 属性为 NONE 或者 AES-128.    
NONE 表示 URI 以及 IV \(Initialization Vector\) 属性必须不存在; AES-128\(Advanced EncryptionStandard\)表示 URI 必须存在, IV 可以不存在.    
对于 AES-128 的情况, keytag 和 URI 属性共同表示了一个key文件, 通过URI可以获得这个 key, 如果没有IV \(Initialization Vector\), 则使用序列号作为IV进行编解码, 将序列号的高位赋到 16 个字节的 buffer 中, 左边补 0; 如果有 IV, 则将改值当成 16 个字节的 16 进制数.

__\#EXT-X-PROGRAM-DATE-TIME__    
将一个绝对时间或是日期和一个媒体段中的第一个 Sample 相关联, 只对下一个 meida URI 有效    
例子: `#EXT-X-PROGRAM-DATE-TIME:2010-02-19T14:54:23.031+08:00`

__\#EXT-X-ALLOW-CACHE:&lt;YES|NO&gt;__    
是否允许做 cache, 这个可以在 PlayList 文件中任意地方出现, 并且最多出现一次, 作用效果是所有的媒体段.

__\#EXT-X-PLAYLIST-TYPE__    
提供关于 PlayList 的可变性的信息, 这个对整个 PlayList 文件有效, 是可选的, 格式如下: `#EXT-X-PLAYLIST-TYPE:` 如果是 VOD, 则服务器不能改变 PlayList 文件; 如果是 EVENT, 则服务器不能改变或是删除 PlayList 文件中的任何部分, 但是可以向该文件中增加新的一行内容. 

__\#EXT-X-ENDLIST__    
表示 PlayList 的末尾了, 它可以在 PlayList 中任意位置出现, 但是只能出现一个, 但作为直播的, 不需要这个 tag

__\#EXT-X-STREAM-INF__    
指定一个包含多媒体信息的 media URI 作为 PlayList, 一般做 M3U8 的嵌套使用, 它只对紧跟后面的 URI 有效

有以下属性: 

+ BANDWIDTH: 带宽, 必须有
+ PROGRAM-ID: 该值是一个十进制整数, 惟一地标识一个在 PlayList 文件范围内的特定的描述. 一个 PlayList 文件中可能包含多个有相同 ID 的此 tag
+ CODECS: 不是必须的
+ RESOLUTION: 分辨率
+ AUDIO: 这个值必须和 AUDIO 类别的 `EXT-X-MEDIA` 标签中 `GROUP-ID` 属性值相匹配.
+ VIDEO: 同上

## 一个 m3u8 文件请求例子

由于 PC 端我当前使用的 Chrome 还不支持 HTML5 中用 `<video>` 标签播放 HLS, 所以我只能是找来了一个视频播放器来打开 M3U8 链接, 接着用 Wireshark 抓包来分析.

顺道一提, HTPP 请求的 raw 数据, 可以在 Wireshark 中通过右键菜单选到 `follow` =&gt; `TCP Stream` 或者菜单栏中的 `Analyze` =&gt; `follow` =&gt; `TCP Steam` 来查看.

M3U8 的请求如下:

### 发出请求

```
GET /live/virgin1/chunklist_w63623014.m3u8 HTTP/1.1
User-Agent: Daum PotPlayer
Host: wow01.105.net
Cache-Control: no-cache
```

### 返回 Header

```
HTTP/1.1 200 OK
Date: Fri, 17 Jun 2016 03:35:58 GMT
Content-Type: application/vnd.apple.mpegurl
Accept-Ranges: bytes
Server: WowzaStreamingEngine/4.2.0.01
Cache-Control: no-cache
Content-Length: 213
```

### 返回内容

```
#EXTM3U
#EXT-X-VERSION:3
#EXT-X-ALLOW-CACHE:NO
#EXT-X-TARGETDURATION:15
#EXT-X-MEDIA-SEQUENCE:1974
#EXTINF:7.64,
media_w63623014_1974.ts
#EXTINF:9.24,
media_w63623014_1975.ts
#EXTINF:0.96,
media_w63623014_1976.ts
```

请求到 M3U8 文件后, 读取到里面的描述信息, 就会根据信息中的 `SEQUENCE` 去请求对应的 TS 文件, 假如是直播的话, 则会一直请求这个 M3U8 文件, 但是返回的 `SEQUENCE` 已经不同了.

## 请求一个 TS 文件

```
GET /live/virgin1/media_w63623014_1972.ts HTTP/1.1
User-Agent: VLC/2.2.1 LibVLC/2.2.1
Host: wow01.105.net
Cache-Control: no-cache

HTTP/1.1 200 OK
Date: Fri, 17 Jun 2016 03:35:59 GMT
Content-Type: video/MP2T
Accept-Ranges: bytes
Server: WowzaStreamingEngine/4.2.0.01
Cache-Control: no-cache
Content-Length: 1274640
```

## 带嵌套的 M3U8 文件

```
#EXTM3U
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=1280000
http://example.com/low.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=2560000
http://example.com/mid.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=7680000
http://example.com/hi.m3u8
#EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=65000,CODECS="mp4a.40.5"
http://example.com/audio-only.m3u8
```

上边通过设定不同的 `BANDWIDTH` 可以让设备选择合适的列表进行播放.

# TS 文件

TS 文件为传输流文件, 视频编码主要格式 h264/mpeg4, 音频为 acc/MP3. 关于视频编码, 音频编码一类的, 我还不是很清楚, 就大概知道这么回事就好了.

# 拓展

- [视频直播大概包含哪些环节](https://www.zhihu.com/question/42162310/answer/93858266)
- [Open Broadcast Software](https://obsproject.com/) 开源的 PC 直播软件\(录制/直播流传输\)
- [nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) nginx 模块, 支持 RTMP 及 HLS、DASH 等