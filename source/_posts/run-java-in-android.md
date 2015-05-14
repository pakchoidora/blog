title: "在 Android 系统上执行 Java 程序"
date: 2015-0-31 10:43:22
figure:
description: 之前一阵子在有在使用 Android 平台上的 UiAutomator 编写一些自动化脚本, 然后我就在想, UiAutoamtor 程序是怎么执行起来的, 在编写程序的时候也感觉 UiAutomator 似乎与一般的 Java 程序无异, 那么, 我们是否可以在 Android 上来执行 Java 程序呢.
tags:
- Java
- Android
categories:
- Code
---


之前一阵子在有在使用 Android 平台上的 UiAutomator 编写一些自动化脚本, 然后我就在想, UiAutoamtor 程序是怎么执行起来的, 在编写程序的时候也感觉 UiAutomator 似乎与一般的 Java 程序无异, 那么, 我们是否可以在 Android 上来执行 Java 程序呢.

在 Android 平台上, 进行自动化脚本开发的时候, 我们使用了 Android 官方提供的 UiAutomator. 而 UiAutomator 的本质其实就是 Java 程序. 它的入口是一个名为 uiautomator 在 /system/bin 下的 shell 程序.

对这个 shell 程序进行分析, 我们不难发现, 它实际上有几个重要的点

1. 设置 ANDROID_DATA 环境变量

![ANDROID_DATA](http://7xirxu.com1.z0.glb.clouddn.com/2015/01/ANDROID_DATA.png)

2. 设置 CLASSPATH 环境变量

假如不设置 CLASSPATH 的话, 我们没有办法查找到我们的程序 Jar 包.

![CLASSPATH](http://7xirxu.com1.z0.glb.clouddn.com/2015/01/CLASSPATH.png)

3. 执行 exec app_process 命令

![exec app_process](http://7xirxu.com1.z0.glb.clouddn.com/2015/01/app_process.png)

直接执行, 会发现它会要求我们提供一个 Class name

![dalvikvm](http://7xirxu.com1.z0.glb.clouddn.com/2015/01/dalvikvm.png)

这里值得注意的是, 它支持 -cp 命令, 所以我们可以通过 -cp 来指定我们的类库依赖, 比如:

    adb shell dalvikvm Hello -cp /data/local/tmp/hello-dex.jar

但是这里需要注意, 只支持 dex 可执行文件.

Ps: 当我们使用非 root 权限, 或者 USER_ID 不等于0 的时候, 我们需要设置 ANDROID_DATA 方能使用, 不然会直接出现 Aborted 的结果

    ANDROID_DATA=/data/local/tmp CLASSPATH=/system/framework/uiautomator.jar:/system/framework/android.test.runner.jar exec app_process /system/bin com.android.commands.uiautomator.Launcher
