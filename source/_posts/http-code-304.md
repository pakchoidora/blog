title: "HTTP 304 状态与浏览器缓存"
date: 2015-04-02 22:51:46
figure:
description: Http Status Code 304 与浏览器缓存的一些简单理解.
tags:
- HTTP
- 304
---



事情起因是之前有人问起一个问题, 说他加载了页面后, 打开浏览器的开发者工具后发现在 Network 里, 很多资源的传输大小都是 200B.

而且当我们点开了菜单中的 `Use large request rows` 按钮后, 我们在 `Size/Content` 列会看到两个大小不同的数值, 而假如我们启用了浏览器 cache 时, 往往 `Content` 值要比 `Size` 值小得多, 这是因为啥呢.

![browser cache](http://7xirxu.com1.z0.glb.clouddn.com/2015/04/browser-cache.png)

而且我们注意到, Status 栏写着 304, 文本则为 `Not Modified`.

所以, 问题来了, 这里的 304 指的是 `HTTP Status Code 304`, 但是 `HTTP Status Code 304` 究竟表示什么意思呢.

首先我们要知道 `HTTP Status Code 304` 究竟表达什么意思, 所以在查阅了 [维基老头的图书馆](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#3xx_Redirection) 后, 我们发现:

> **304 Not Modified**
>     Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. This means that there is no need to retransmit the resource, since the client still has a previously-downloaded copy.

它表示着, 该请求资源自从上次请求后, 没有被修改过, 因而不会重新传输该资源, 而是从缓存中获取.

浏览器在 Request Header 中加入 `If-Modified-Since` 字段, 或者 `If-None-Match` 字段来描述一个具体版本的资源. 如下图的一个请求的 `Header` 信息.

![browser cache request](http://7xirxu.com1.z0.glb.clouddn.com/2015/04/browser-cache-request.png)

我们可以看到, `Request Headers` 中, 有着 `If-None-Match` 两个字段, 而与之对应的, 在 `Response Header` 中有个 `ETag` 的属性, 当它的值与 `If-None-Match` 一致, 即表示该文件自上次请求至今没有发生修改.

ETag 的描述为:

> **ETag**
>     An identifier for a specific version of a resource, often a message digest

`ETag` 属性的值是某个版本中的一个资源的标识符.

因为浏览器缓存的存在, 我们经常在查看网络请求时, 有的文件明明有好几十KB, 但是请求时, 返回的却只有几百 Bytes, 这其实就是因为 `HTTP Status Code 304`, 资源没有修改, 浏览器使用缓存中的资源.

而当我们禁用缓存时, 每次正常请求都是跟资源大小相近的.