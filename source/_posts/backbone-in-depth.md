title: "深入理解 Backbone"
date: 2015-05-31 00:09:37
figure:
description: 研究 Backbone 说来也有一阵子了, 而 Backbone 本身也并不复杂, 我们常将它与 Angular.js 等框架进行比较, 但 Backbone 它相比较于 Angular.js, 是很灵活的一个框架, Backbone 可以与其它框架诸如 jQuery, 亦或是最近比较火的 React.js 很好的协作. 本篇将深入的讲讲 Backbone 的使用.
tags:
- Backbone
- jQuery
- JavaScript
---


# 前言

研究 Backbone 说来也有一阵子了, 而 Backbone 本身也并不复杂, 我们常将它与 Angular.js 等框架进行比较, 但 Backbone 它相比较于 Angular.js, 是很灵活的一个框架, Backbone 可以与其它框架诸如 jQuery, 亦或是最近比较火的 React.js 很好的协作.

Backbone 它提供了四个类, Model, View, Collection, Router, 其实它只是帮我们规范了编码以及代码结构, 实现的功能并没有很强大, 但是它提供的功能也已经满足我们的基本需求了, 需要更细致, 更复杂的功能, 我们只需要对其进行拓展即可.

顺带一提, 虽然 Backbone 可以独立运作, 但是跟 jQuery, 或者 Zepto 等类库一起工作效果更佳, 下文默认为与 jQuery 类库共存的环境下来编写示例代码.

关于函数作用, 在 Backbone 官网上能找到, 在此就不细说了.

下边就分别来讲这四个类.

# Model

我们可以通过调用 Backbone.Model.extend 函数来编写我们的 Model 类,

{% codeblock %}
    var User = Backbone.Model.extend({
      initialize: function() {
        // 初始化操作
      }
    });
{% endcodeblock %}

`initialize` 函数会在调用 `new User()` 后被调用, 充当 `User` 类的构造函数.

我们还可以设置 `defaults` 属性, 用来定义 Model 的默认状态值(attributes, 保存着所谓的数据).

{% codeblock %}
    var User = Backbone.Model.extend({
      defaults: {
        staff: false
      }
    });
{% endcodeblock %}

这样默认 `staff` 的状态值即为 `false`.

Backbone.Model 中提供了一系列的函数, 以及继承了 Underscore 中函数, 所以大部分我们都是可以直接使用的, 比如 `fetch`, `save`, `destroy`, `has` 等函数, 具体可以查看 [这里](http://backbonejs.org/#Model).

但是, 这些函数我们是可以自行重写的, 比如 `fetch`, 默认情况下, 它会根据当前 `Model` 对象的 `id` 值, 发送一个 `GET` 请求. 假如我们定义了 `urlRoot` 比如下列代码例子:

{% codeblock %}
    var User = Backbone.Model.extend({
      urlRoot: '/user',
      initialize: function() {
        // 初始化操作
      }
    });

    var user = new User({id: 11});
    user.fetch();
{% endcodeblock %}

那么, `Backbone` 它会发送一个 `GET` 请求到 `/user/11`, 因为它是根据 `RESTful API` 来设计的, 但是我们实际项目中, 并不一定会这么去设计接口(比如我现在的项目就不是... 令人忧伤的事实). 所以当我们的接口并不是根据 `RESTful API` 来的, 这时候我们就需要重写 `fetch` 函数了.

而除却这种情况, 大部分 Model 类的成员函数是不需要我们进行修改的, 比如 `set`, `has`, `clear` 等, 当然啦, 除非你有这个需求, 那还是得对它们进行重写, 但是大部分情况下是不需要的.

# Collection

Collection 类是同一 Model 数据的集合.

{% codeblock %}
    var Users = Backbone.Collection.extend({
      model: User
    });
{% endcodeblock %}

Collection 与 Model 实际上是很相似的, 但是 Collection 是 Model 的集合, 我们可以把它俩理解为一个是数组, 一个是数组中的元素.

与上边说到的 Model 的 `fetch` 函数类似的, Collection 类中也提供了 `fetch` 函数, 所以有需要的话我们一样要重写它的 `fetch` 函数.

我们还可以设置 `model` 属性, 这样, 该 Collection 类就会以 `model` 属性所指的 Model 类来封装 Collection 中的数据.

一样以 `fetch` 函数为例子, 比如我们重写了 Model 类的 `fetch` 函数, 那么我们在使用 Collection 来获取对应的数据集合时, 也要指定 `model` 属性, 这样才不至于得到的 Model 集合仍用着 Backbone.Model 默认提供的方式去发送请求.

# View

{% codeblock %}
    var UserView = Backbone.View.extend({
      el: 'body',
      template: _.template('<div class="user-view"></div>'),
      initialize: function() {
      	this.render();
      },
      render: function() {
        this.$el.html(this.template());
      }
    });

    new UserView();
{% endcodeblock %}

Backbone 中, 每个 View 对象都是有对应的 DOM 元素的, 我们在 `extend` 函数中设置 `el` 属性来使该 View 的对象 DOM 元素相关联.

但是, 设置 `el` 属性只是其中的一个方法, 我们还可以通过 `setElement` 函数来实现, 个人也比较推荐后者, DOM 元素应该是灵活可变的, 而不是在定义 View 类时就被写死了的.

{% codeblock %}
    var UserView = Backbone.View.extend({
      template: _.template('<div class="user-view"></div>'),
      initialize: function() {
        this.render();
      },
      render: function() {
        this.setElement(this.template());
      }
    });

    $('body').html(new UserView().$el);
{% endcodeblock %}

比较上边两个 UserView 类的定义及使用, 实际效果是没有区别的, 但是, 后者相对比较灵活, 它不是跟某个其它 DOM 元素相关联起来的, 而是跟自身的 `template` 函数生成的 DOM 元素所关联, 所以我们不需要考虑 `el` 属性究竟该写什么, 只需要考虑 `$el` 对象会被填充到 DOM 的哪个地方.

这里还有一个问题, Backbone 并没有提供 View 嵌套, 但这并不是说它不支持, 我们只是要将子 View 的 `$el` 对象添加到当前 View 的 `$el` 对象中的某个地方即可.

View 中的 `$el` 对象即是 jQuery 对象(抑或是 Zepto 对象, ender 对象), 所以可以直接使用它们的 DOM 操作 API. 参考第二个 UserView 中使用的方式一样.

# Router

{% codeblock %}
    var UserRouter = Backbone.Router.extend({
      routes: {
        'help': function() {
          ...
        },
        'search/:query': 'search'
      }
      search: function(query) {
        ...
      }
    });
{% endcodeblock %}

Router 类中, 我们可以通过定义 `routes` 属性, 来指定各个路由规则. 值可以是字符串, 也可以是匿名函数.

我们还可以通过 Router 中的 `route` 函数, 来动态定义路由规则.

另外, Router 中的 `navigate` 函数, 我们在 Router 对象外也可以通过 `Backbone.history.navigate` 函数来调用.

实际上 Backbone 所提供的功能并不是很多, 但是它提供了一个大概的方向, 而且很灵活, 进行必要的二次封装后, 就会变得特别方便.