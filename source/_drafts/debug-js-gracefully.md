title: "debug-js-gracefully"
tags:
- JavaScript
- Debug
- Chrome Developer Tools
figure: 
---


# 前言

本篇大概说说在 Web 中以及 Node.js 中 JavaScript 的 Debug 方法及工具, 优雅的调试我们的 JavaScript 代码.

JavaScript 在 Web 中以及 Node.js 中由于运行环境有所不同, 所以这里分开 Web 执行环境及 Node.js 执行环境来讲 JavaScript 的代码调试.

# Web 中的 JavaScript

Web 中的 JavaScript, 它们的执行环境即是浏览器, 这里不得不说起的, 就是 Google Chrome 上的 Developer Tools, 绝对是前端开发中的一大利器.

在我们的页面中右键选择审查元素, 或者是按 F12 键, 即可调出 Developer Tools, 而这时候, 我们要调试 JavaScript 代码, 那么我们先在菜单栏里切换至 `Sources` 标签页中.

在左边的资源树中选择我们需要添加断点的代码文件.

它可以是 HTML 文件里 Script 标签中的代码, 也可以是 js 文件中的代码.

![Developer Tools](///贴图片, 图片还需要处理)

我们可以在中间的代码区添加代码断点, 在行数数字所在位置点击即可添加断点, 再次点击取消, 跟大部分 IDE 中添加删除断点是相似的.



# Node.js 中的 JavaScript