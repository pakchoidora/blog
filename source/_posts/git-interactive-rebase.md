title: "Git 交互式变基"
date: 2015-03-17 13:56:52
figure:
description: 我们知道 Git 中它提供了几个命令来让我们进行代码合并操作, 分别有 git merge, git pull 还有 git rebase. 然而 git rebase 与前两者有什么区别, 而 Git 交互式变基又是啥呢?
tags: 
- git
categories:
- Software
---


# git rebase 简介

我们知道 Git 中它提供了几个命令来让我们进行代码合并操作, 分别有 `git merge`, `git pull` 还有 `git rebase`.
它们之间是有着不少细节上的区别, 由于 `git pull` 平时较少用, 所以我们这里就只比较下 `git rebase` 以及 `git merge` 两者之间的区别.
至于为何 `git pull` 平时较少使用, 可以[查看此](http://stackoverflow.com/questions/15316601/in-what-cases-could-git-pull-be-harmful).

## git rebase 作用

一般情况下, `git rebase` 跟我们使用 `git merge` 是没两样的, 它们都可以用来将本地代码与其它分支上的代码进行合并.
但是假如我们生成了大量的提交, 那么我们会遇到一些问题, 在团队协作上, 也会加大代码合并的成本. 而 git rebase 可以对我们本地尚未推送到远端的提交进行编辑处理.

# git rebase 命令详解

首先我们可以先在终端里输入 `git help rebase` 来查看 `git rebase` 的官方帮助文档.

![git-rebase-synopsis.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-synopsis.png) 

一般用法:

`git rebase [<upstream> [branch]]`, 我们在一般情况下, 都是针对远端上的 master 分支来进行变基, 所以这里就以远端的 master 分支做为例子.

注: 本文中的"变基" 均表示 rebase 操作.

## 交互式变基

交互式变基, 其实即是对应着 `git rebase -i` 或者是 `git rebase --interactive`
突出点在于可以交互式编辑我们本地的提交.

当我们在终端里执行 `git rebase --interactive origin/master` 的话, 那么我们会看到下图类似的一个内容.

![git-rebase-i-sample.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-i-sample.png)

根据上图中的内容, 我们可以看到, 交互式变基里, 有 6 个命令, 分别是:

 + p, pick - 使用该提交
 + r, reword - 使用该提交, 同时编辑提交消息
 + e, edit - 使用该提交, 但是会停止变基操作, 等待对提交进行修改操作
 + s, squash - 使用该提交, 并且将该提交跟上一个提交融合到一起
 + f, fixup - 与 squash 相同, 但是丢弃该提交的日志消息
 + x, exec - 执行命令, exec 命令后边接 shell 命令

上图表示, 这时候我们进入了 git rebase todo 列表.
列表中的内容是有固定格式的, 除了 `exec` 命令外, 其它都是

command commit-id commit-comment

的结构.

# git rebase 实战

假如我们现在有两个分支如下.

![branch-topic](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/branch-topic.png)

那么我们进行 `git rebase master topic` 操作后, 结果将会是

![rebase-result](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/rebase-result.png)

我们看到, topic 上的几个提交, C, D, E 原本都是在 B 提交之后的, 现在它们被移动到了 G 之后.

而同样的这个情况下, 假如我们通过命令 `git merge master topic` 来将 master 分支上的更改合并到 topic 分支上, 那么会出现 E 跟 G 两个提交点连接到一块, 如下图所示

![merge-result](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/merge-result.png)

git rebase 的作用就类似于此, 还有其它更具体的功能, 可以从文档里去了解, 这里就不细细说明了, 只解释一些基本的内容.

## 在 Gerrit 仓库上使用

当我们在使用 Gerrit 仓库的时候, 因为 Gerrit 它有提供 Code Review 功能, 所以我们在每次提交的时候, 都需要为我们的提交添加 Change-Id 的备注.
Gerrit 上的要求是, 每个 Commit 都必须要有一个 Change-Id 值作为结尾, 但是, 假如之前的某一个提交里并没有添加 Change-Id, 那么, 我们是无法成功将本地的提交推送到远端上的.

一般情况下, 我们直接进行 `git commit --amend` 命令就好了, 但是这个只对上一个提交生效, 对于非上一个提交, 是无法进行修改的, 所以这时候我们就可以通过交互式变基来解决我们的问题, 将多个提交合并为一个, 或者是, 为那个没有 Change-Id 的提交补充一个 Change-Id.

在终端上, 我们执行 `git rebase -i origin/master`, 然后除了第一个提交, 其它的 command 位置都修改为 squash, 像下图.

![git-rebase-squash-sample.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-squash-sample.png)

注意: 这里是使用 vim 来进行编辑的, 修改完毕后, 按 esc 键确认进入命令模式, 然后输入 `:wq` 来保存我们的操作并且退出, 然后就会看到 COMMIT_EDITMSG 操作, 如下图.

![git-rebase-edit.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-edit.png) 

然后我们稍加编辑, 把多余的 Change-Id 给移除掉, 然后把内容做下对齐.

![git-rebase-edit-complete.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-edit-complete.png) 

然后回到 VIM 的命令模式, 输入 `:wq` 保存我们的修改, 就可以看到 `git rebase` 已经在开始执行我们的修改了.

![git-rebase-console-result.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-console-result.png) 

![git-rebase-log.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-log.png) 

而在 SourceTree 中, 操作就相对简单了不少, 对着我们需要进行交互式变基的那个提交右键, 然后如下图所示, 即可打开交互式变基的对话框.

![git-rebase-source-tree-sample-1.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-source-tree-sample-1.png) 

接着就根据下方所提供的按钮来进行操作就行了.

![git-rebase-source-tree-sample-2.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-source-tree-sample-2.png) 

![git-rebase-source-tree-sample-3.png](http://7xirxu.com1.z0.glb.clouddn.com/2015/03/git-rebase-source-tree-sample-3.png)
