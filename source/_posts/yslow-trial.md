title: YSlow 试用
tags: YSlow
date: 2015-07-09 16:15:12
figure:
description: YSlow 分析工具的简单试用.
---


今天被问到测试前端页面性能时, 脑子里只蹦出了 Loadrunner 压测, 以及 PageSpeed, 然后被告知还有 YSlow 这么一个工具, 我也是半天没听出来是个啥...

------ 

YSlow 是一个 Web 页面的分析工具, [yslow.org](http://yslow.org) 上的说明是: "YSlow 是用来分析 Web 页面慢的原因的工具", 原文见下.

> YSlow analyzes web pages and why they're slow based on Yahoo!'s rules for high performance web sites.

YSlow 在多个浏览器及平台中都是可用的.

[![可用性](http://7xirxu.com1.z0.glb.clouddn.com/2015/07/09/yslow-availability.png)](http://yslow.org/ruleset-limitations/)

它从 Yahoo 的卓越性能 34 条规则中挑选了 23 条作为它的评判标准, 详细见下边列出来的 23 条规则, 而 Yahoo 的卓越性能规则请看[这里](https://developer.yahoo.com/performance/).

1. 减少 HTTP 请求 \(Minimize HTTP Requests\)
2. 使用内容分发网络 \(Use a Content Delivery Network\)
3. 避免使用空的 src 或者 href 属性 \(Avoid empty src or href\)
4. 在 Header 中添加 Expires 或者 Cache-Control \(Add an Expires or a Cache-Control Header\)
5. 使用 Gzip 压缩组件 \(Gzip Components\)
6. 将样式表放在文档顶部 \(Put StyleSheets at the Top\)
7. 将 JavaScript 代码放在文档底部 \(Put Scripts at the Bottom\)
8. 避免使用 CSS 表达式 \(Avoid CSS Expressions\)
9. 使用外部 JavaScript 及 CSS \(Make JavaScript and CSS External\)
10. 减少 DNS 查找 \(Reduce DNS Lookups\)
11. 压缩 JavaScript 及 CSS 代码 \(Minify JavaScript and CSS\)
12. 避免使用重定向 \(Avoid Redirects\)
13. 移除重复的脚本 \(Remove Duplicate Scripts\)
14. 配置 ETags \(Configure ETags\)
15. 使 Ajax 内容可缓存 \(Make AJAX Cacheable\)
16. 在 AJAX 请求中, 使用 GET 方法 \(Use GET for AJAX Requests\)
17. 减少 DOM 元素的数量 \(Reduce the Number of DOM Elements\)
18. 不要使用 404 \(No 404s\)
19. 减少 Cookie 的大小 \(Reduce Cookie Size\)
20. 使用 Cookie-Free 的域名来提供组件 \(Use Cookie-Free Domains for Components\)
21. 避免使用 Filter \(Avoid Filters\)
22. 不要在 HTML 中缩放图片 \(Do Not Scale Images in HTML\)
23. 使用小体积的 favicon 并且使其可缓存 \(Make favicon.ico Small and Cacheable\)

我们可以看到, 其中的 14 条是在 ["High Performance Web Sites"](http://www.amazon.com/High-Performance-Web-Sites-Essential/dp/0596529309/ref=sr_1_1) 被提及到的.

安装 YSlow 比较简单, 在 [YSlow.org](http://yslow.org) 首页的顶部就有 Install 的按钮, 这里我使用 Google Chrome. 点击 Install, 即会弹出 Chrome Extension 的安装提示.

![安装提示](http://7xirxu.com1.z0.glb.clouddn.com/2015/07/09/yslow-extension.png)

点击添加即可.

然后当我们需要对一个页面使用 YSlow 进行分析时, 我们可以在 Google Chrome 地址栏右边点击 YSlow 的按钮, 即可打开 YSlow.

![YSlow 默认页](http://7xirxu.com1.z0.glb.clouddn.com/2015/07/09/yslow-home.png)

然后点击, Run Test, 稍加等待, 即可看到结果.

![YSlow 分析中](http://7xirxu.com1.z0.glb.clouddn.com/2015/07/09/yslow-running.png)

在 Grade 页面中, 我们可以看到上边列出的 23 点规则, 左边的大写字母为评分, A 为最好, F 为最差. 点击某个规则可以看到具体说明.

![YSlow 打分页](http://7xirxu.com1.z0.glb.clouddn.com/2015/07/09/yslow-grade.png)