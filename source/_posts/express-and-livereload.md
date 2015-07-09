title: "Express 中配置 livereload"
date: 2015-05-14 09:54:44
figure:
description: LiveReload 是 Web 开发中的实用的工具, 它可以让我们不用再在每次修改完文件之后手动刷新页面, 它会自动为我们刷新. 本文将讲讲如何在 Express.js 框架中加入 LiveReload.
tags:
- Express
- Node.js
- LiveReload
categories:
- Software
---


# LiveReload 是什么

LiveReload 是 Web 开发中的实用的工具, 它可以让我们不用再在每次修改完文件之后手动刷新页面, 它会自动为我们刷新.

LiveReload 它分为三部分, 客户端目标代码及服务端, 还有浏览器插件.

在学习如何配置之前, 我们先逆向思维下, 从已经配置了 LiveReload 的项目中来了解 LiveReload 究竟是做了些啥.

通过审查加入了 LiveReload 的页面我们知道, LiveReload 它在我们的页面中的底部增加了类似下面这些代码:

    <script>//<![CDATA[
    document.write('<script src="//' + (location.hostname || 'localhost') + ':35729/livereload.js?snipver=1"><\/script>')
    //]]></script>

它会为我们 HTML 文件末尾添加一个 `script` 标签, 用来请求本地的一个服务端中请求 livereload.js 这个 js 脚本.

# 怎么在 Express 中配置 LiveReload

所以这里就出现了两个问题:

1. 上面的那段代码是从哪来的?
2. livereload.js 这个文件又是从哪来的?

关于第一个问题, 上面的那段代码是从哪来的?

这个不可能是我们手动去给每个页面添加的, 这样做不魔法.

Express 中有这么一个中间件 `connect-livereload`, 它就为我们办这件事. [项目页在此](https://www.npmjs.com/package/connect-livereload). Ps: `connect-livereload` 它并不提供 livereload.js 这个文件.

为 Express 对象添加这个中间件即可.

    var express = require('express');
    var app = express();
    app.use(require('connect-livereload')({
      port: 35729
    }));

所以到这里, 我们就算是把客户端上的 livereload 给配置好了.

第二个问题, livereload.js 这个文件又是从哪来的?

我们可以观察到, 它是从某个 http 服务中请求过来的.
所以, 这里我们就需要这个 http 服务了.

我们可以直接通过 npm 下载 livereload 然后运行.

    npm install -g livereload

然后执行

    livereload -p 35729

在 35729 端口上运行 livereload 的服务端.

但是同时, livereload 也支持 gulp, grunt 这两个构建工具, 我们都可以在他们的 plugins 页面中搜索到相关.
\(Ps: grunt 中已经集成了 livereload 在 `contrib-watch` 模块中\)

# LiveReload 在 gulp 中

以 gulp 为例子, 我们需要插件 `gulp-livereload`, 而且在 gulp 中需要做两件事:

1. 启动 LiveReload 的服务端;
2. 调用 LiveReload 的重新加载.

    var livereload = require('gulp-livereload');
    gulp.task('watch', function() {
      livereload.listen({
        port: 35729
      });

      gulp.watch(['public/**/*', 'views/**/*.jade'], function(event) {
        gulp.src(event.path)
          .pipe(livereload());
      });
    });

上述中, 第三行代码 `livereload.listen({port: 35729});` 即是启动我们的 LiveReload 服务端.

然后, 我们给当前 task 添加一个文件监听, 监听 public 及 views 目录下文件的变动, 然后对该变动的文件执行操作.

在 grunt 中也是类似的, 在此就不多说明. 详情可见 [此](https://www.npmjs.com/package/grunt-contrib-watch#options-livereload), 插件页有详细的说明.