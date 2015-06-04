title: "Node.js 与隔壁老王(GET/POST)参数的二三事"
date: 2015-03-29 13:25:59
firgure:
description: 由于最近的一项工作中有需要使用 Node.js 来编写一个 HTTP 工具, 其中就有包括 GET/POST 参数的处理, 也遇到了一些小问题, 所以顺便就写下来, 作为一个小知识普及.
tags: 
- Node.js
- HTTP
categories:
- Code
---


由于最近的一项工作中有需要使用 Node.js 来编写一个 HTTP 工具, 其中就有包括 GET/POST 参数的处理, 也遇到了一些小问题, 所以顺便就写下来, 作为一个小知识普及. 嗯, 就是酱紫, 不要问我隔壁老王是谁.

## HTTP GET 以及 HTTP POST 两者的区别.

首先我们先了解下 HTTP GET 与 HTTP POST 两者有什么不同

### 相同点:

它们都是 HTTP 中的一种发送请求方式. 并不是广义上的一个取, 一个发. 所以不要被名字所误导了.

### 不同点:

GET 与 POST 方式常常被提到的区别就有: 1. 安全性, 2. 传输数据大小, 3. 数据传输方式.

但是在这里我们仅仅来讨论它们两者数据的传输方式不同, 更多内容可以查阅维基老头给我们的说明. [点我拜访维基老头](http://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Request_methods)

**POST**

先说说 POST 方式, 它是将数据各字段及内容添加到请求的 HEADER 中去, 然后随着请求发送到服务器端, 这个过程是不可见的;

**GET**

GET 方式, 是将参数数据队列添加到 URL 中去的, 所以我们常常可以看到 URL 中使用 '&' 符号来拼接各种键值对应的参数.

如: http://localhost:1337/index?name=root&password=1234

但是这种方式就存在安全问题了, 具体在这就不做讨论了.

## Node.js 中如何处理请求参数

前边一堆废话过去了, 是时候进入主题了.

在 Node.js 的官网上我们可以看到, 官方给出了一个简单的 HTTP Server 程序例子.

这部分以官网上的代码为例, 来理解 Node.js 中 GET/POST 参数的获取.

    var http = require('http');
    http.createServer(function (request, response) {
    	response.writeHead(200, {'Content-Type': 'text/plain'});
    	response.end('Hello World\n');
    }).listen(1337, '127.0.0.1');
    console.log('Server running at http://127.0.0.1:1337/');

在这个例子中, 假如我们需要获取 GET/POST 方式传递过来的参数, 是无法直接得到的, 需要对 request 对象进行处理, 才可以得到我们想要的参数.

### 在 GET 方式中:

参数都是以键值方式拼接在请求的 URL 当中的, 所以我们可以通过解析 URL 来获得参数.

我们可以通过 Node.js 内建的 url 库来解析 GET 请求过来的 URL.

    var url = require('url');
    然后调用 url.parse 函数.

    var params = url.parse(request.url, true).query;  // params 即为我们需要的参数
    然后打开浏览器, 尝试请求我们的 HTTP Server.

如: http://localhost:1337/index?username=root&action=test , 在 url 中附带参数.

然后打印我们的 params, 即可看到如下图的内容.

![get-params.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/get-params.png)

完整的代码如下:

{% codeblock %}
    var http = require('http');
    var url = require('url');
    http.createServer(function (request, response) {
      var params = url.parse(request.url, true).query;
      console.log(params);
      response.writeHead(200, {'Content-Type': 'text/plain'});
      response.end('Hello World\n');
    }).listen(1337, '127.0.0.1');
    console.log('Server running at http://127.0.0.1:1337/');
{% endcodeblock %}

### 在 POST 方式中:

由于 POST 方式传递的参数并不会显示在 URL 中, 所以上边的方式就不可行了, 那么我们就要换一种方式了.

前边我们已经知道了, POST 方式, 它会将参数数据添加到请求的 HEADER 中发送到服务端, 所以, 我们需要去解析 HEADER 中的数据来获取 POST 请求发送过来的参数.

这里我们就需要使用 'querystring' 这个库了, 用来处理 response 对象的数据, 完整代码如下.

{% codeblock %}
    var http = require('http');
    var querystring = require('querystring');
    http.createServer(function (request, response) {
      request.setEncoding('utf-8');
      var postData = '';
      // 注册监听, 接收数据块
      request.addListener("data", function (postDataChunk) {
          postData += postDataChunk;
      });
      // 数据接收完毕, 执行回调函数
      request.addListener("end", function () {
        var params = querystring.parse(postData);  //解析 HEADER 中的数据
        console.log(params);
        response.writeHead(200, {'Content-Type': 'text/plain'});
        response.end('Hello World\n');
      });
    }).listen(1337, '127.0.0.1');
{% endcodeblock %}

由于 POST 传输数据的量相较于 GET 方式较大, 所以这里并不能直接得到数据, 而是通过添加两个监听器, 分别处理数据接入过程以及数据接入完两个状态.

但是, 这并不是最理想的. 当你是通过 'FORM-DATA' 方式发送请求的话, 我们接收到的结果并不是我们想象中的样子. 比如我通过 POSTMAN 去发送一个 'FORM-DATA', 其中包含了 'name' 及 'password' 两个字段的数据. 我们解析出来的结果是如下图:

![post-form-data](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/post-form-data.png)

它虽然是一个 JS 对象, 但是它的内容于我们而言几乎是不可用的, 尽管依稀可以见到 'name' 跟 'password' 两个字段, 但是处理起来还是比较费劲.

而当我们在发送数据时, 是通过发送 'application/json' 类型的数据, 如下图 POSTMAN 的使用.

![postman](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/postman.png)

然后我们就能顺利看到我们传递过来的参数了.

### Express.js 中的请求参数处理

Express 是 Node 服务端里我们比较常见的 Web 框架. Express.js 框架有较为完善的封装, 可以让我们直接获取 GET/POST 方式传递过来的参数.

在 Express.js 框架中, 我们每个请求都会有一个 Request 对象, 通过查阅 API 我们发现, Request 对象有一个 params 属性, 我们发送请求时所附带的参数数据都被保存在其中, 我们可以直接调用.

如: `request.params['name']` 或者是 `request.params.name`.

详见 Express.js 上 Request 对象的 API:  http://expressjs.com/4x/api.html#req.params

## 总结:

理解 GET/POST 两种请求的参数传递方式.

GET 的参数都是附加于 URL 中的, 而 POST 的参数是添加在 RequestHeader 中的.

打完收工.