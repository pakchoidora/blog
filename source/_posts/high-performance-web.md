title: 构建高性能 Web 的 14 条黄金法则
tags:
- Web
date: 2015-06-15 13:18:35
figure:
description:
---


前几天被问到构建高性能 Web 时, 一时脑抽没反应过来这是个啥, 其实平时做的雪碧图, 以及 js 代码压缩等都属于这块的内容, 当然这只是其中的一部分.

------

在 ["High Performance Web Sites"](http://www.amazon.com/High-Performance-Web-Sites-Essential/dp/0596529309/ref=sr_1_1) 这本书中, 我们可以看到, 它列举了 14 条高性能黄金法则.

1. 使用更少的 HTTP 请求 \(Make Fewer HTTP Requests\)
2. 使用内容分发网络 \(Use a Content Delivery Network\)
3. 设置过期 Header \(Add an Expires Header\)
4. 使用 gzip 压缩各组件 \(Gzip Components\)
5. 把样式表放在文档顶部 \(Put Stylesheets at the Top\)
6. 把 JavsScript 代码放在文档底部 \(Put Scripts at the Bottom\)
7. 避免使用 CSS 表达式 \(Avoid CSS Expressions\)
8. 使用外部的 JavaScript 及 CSS 文件 \(Make JavaScript and CSS External\)
9. 减少 DNS 查找 \(Reduce DNS Lookups\)
10. 压缩 JavaScript 代码 \(Minify JavaScript\)
11. 避免使用重定向 \(Avoid Redirects\)
12. 移除重复的脚本 \(Remove Duplicate Scripts\)
13. 配置 ETags \(Configure ETags\)
14. 使 Ajax 内容可缓存 \(Make Ajax Cacheable\)

内容较多, 具体还是看书上如何说明, 篇幅不过 200 页, 很快就可以看完, 这里就不细细写出来了.