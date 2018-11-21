title: Vue 内存泄露
tags: Vue
description:
---

Chrome DevTool, Heap Memory 查看
事件绑定与解绑
适时解除引用
EventBus 没有解绑
window/body 事件没有解绑
Vuex 的 $store 在 watch 之后没有 unwatch
模块形成的闭包内部变量在使用完后没有置成 null
使用第三方库创建, 没有调用正确的销毁函数