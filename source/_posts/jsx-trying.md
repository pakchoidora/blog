title: "初识 JSX"
date: 2015-05-20 23:40:53
figure:
description: React 项目中独特的采用了 JSX 语法, 这究竟是何方神圣, 且看本文来粗略讲讲.
tags:
- JSX
- React
- JavaScript
---


# 前言

说到 JSX, 想必很多人跟我一样, 是因为 React 项目中的使用到 JSX 语法才知道的.

但是其实早在几年前, Github 上就存在着一个名为 JSX 的项目, 是由 [kazuho](https://github.com/kazuho) 等人开发设计的一个可以生成 JavaScript 代码的强类型, 面向对象的编程语言.

这里需要说明白, JSX 其实有两个东西, 他们同名了, 但是功能却是不同的.

1. React 中使用到的 JSX, 有一个简单的描述是, 在 JavaScript 中写 XML 节点, 即是 JSX.
2. Github 上的 JSX 项目, 它是一个静态类型的, 面向对象的编程语言, 它可以通过编译, 生成高性能的 JavaScript 代码. 详情见 [这里](http://jsx.github.io/)

为了避免混乱, 下文一律将 React 中的 JSX 称为 React-JSX, 而 Github 上的 JSX 项目则依旧叫 JSX.

上述两个完全不同的两个东西, 虽然它们都可以通过各自的编译工具最终编译成 JavaScript 代码, 但是在语法上, 是截然不同的. 这个得区分好, 不少人因为 React 中的 `JSX` 结果在跟搜索引擎对话时, 找到了 JSX 项目, 在其中摆了乌龙.

# React-JSX

React-JSX 它并不是一个单独的项目, 它是 React 项目中工具集里的一个, 主要功能是将 jsx 代码中的 xml 元素, 转换成 React.createElement 方式调用. 脱离了 React 项目本身, 它是无法工作的.

React-JSX 的语法与 JavaScript 基本无异, 但是它多了一个特性, 可以将 `<Element className="app"/>` 这样类似的标签理解为一个 ReactElement 对象.

它在转换为 JavsScript 代码后, 会变成

    React.createElement('Element', {className: "app"})

React 在官网中也说到了, Why JSX?

>You don't have to use JSX with React. You can just use plain JS. However, we recommend using JSX because it is a concise and familiar syntax for defining tree structures with attributes.
>
>It's more familiar for casual developers such as designers.
>
>XML has the benefit of balanced opening and closing tags. This helps make large trees easier to read than function calls or object literals.
>
>It doesn't alter the semantics of JavaScript.

使用 JSX 可以使用 HTML Tags 的方式来使用 React 组件, 这样在面对比较大的组件树时, 代码上会比直接使用 React 的函数调用显得比较直观.

以官网上的状态组件: 计时器为例子

    var Timer = React.createClass({
      getInitialState: function() {
        return {secondsElapsed: 0};
      },
      tick: function() {
        this.setState({secondsElapsed: this.state.secondsElapsed + 1});
      },
      componentDidMount: function() {
        this.interval = setInterval(this.tick, 1000);
      },
      componentWillUnmount: function() {
        clearInterval(this.interval);
      },
      render: function() {
        return (
          <div>Seconds Elapsed: {this.state.secondsElapsed}</div>
        );
      }
    });

    React.render(<Timer />, mountNode);

我们可以看到其中用使用了 `<div>Seconds Elapsed: {this.state.secondsElapsed}</div>` 及 `<Timer />` 酱紫的代码, 它们都表示着一个 ReactElement 对象, 不需要使用类似 `React.createElement("Timer", {})` 这样的 API 函数去创建对象, JSX 编译工具会自动帮我们转化.
它带来的, 是代码上清晰直观的体验.

而对于成员变量的调用, 我们可以用 \{\} 符号括起来, 里面写我们需要调用的变量即可.

编译后的代码, 如下:

    var Timer = React.createClass({displayName: "Timer",
      getInitialState: function() {
        return {secondsElapsed: 0};
      },
      tick: function() {
        this.setState({secondsElapsed: this.state.secondsElapsed + 1});
      },
      componentDidMount: function() {
        this.interval = setInterval(this.tick, 1000);
      },
      componentWillUnmount: function() {
        clearInterval(this.interval);
      },
      render: function() {
        return (
          React.createElement("div", null, "Seconds Elapsed: ", this.state.secondsElapsed)
        );
      }
    });

    React.render(React.createElement(Timer, null), mountNode);

可以看到, 与上边的代码比较, 区别仅仅两个 `HTML Tags` 用法被替换成了 `React.createElement()` 的函数调用, 以及 `React.createClass` 补充了一个 `displayName` 的属性.

顺带一提, `React.createClass` 函数所产生的 `ReactClass` 对象中, `state` 是一个特别的数据模型, 随着 `state` 的更新, UI 上也会相应的发生变化. 这就是 React 上的单向数据流.

React 提供了 react-tools 工具集, 其中就包含了 React-JSX 的编译, 首先, 我们通过 npm 安装 react-tools

    npm install -g react-tools

然后就可以使用 jsx 工具来编译我们的代码了.

# JSX

官网在: [http://jsx.github.io/](http://jsx.github.io/)

它不是 JavaScript, 但是它可以通过编译后生成 JavaScript 目标代码.

据官方的说明是, 它的三个特征:

+ faster
+ safer
+ easier

它的语法跟 Java 语言很相似.

举一个项目中的例子

add.js:

    class _Main {
      static function main(args :string[]) : void {
        var x = 10;
        var y = 20;
        log x + y;
      }
    }

通过 npm 我们可以下载 JSX 项目的编译工具.

    npm install -g jsx

然后打开控制台, 执行 `jsx --run add.js`, 即可运行我们上边的这段代码.

跟 Java 类似的, 我们需要有一个程序入口, 在 Java 中, 我们知道有 `static void main(String[] args)` 方法, 而在 JSX 中, 它也是相似的, `static function main(args : string[]) : void`, 并且在 JSX 中, 有个 _Main 的类, 它是程序的入口.

\(Ps: JSX 项目的 jsx 编译工具与 React 的 react-tools 工具集中的 jsx 工具冲突, 安装任一者都会把上一个覆盖掉, 所以在尝试使用两个工具时, 最好为其中一个重命名下批处理, 或者 shell 文件\)