# Flutter初探
![1539587107(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/master/readme_images/1539587107(1).jpg)

> 本文主要大致介绍Flutter 整体框架，简单粗略的使用，深度暂且还没有。
>
> 用Dart，写了个计算器的demo和列表拉下刷新请求demo，基本上入门flutter使用，
>
> 源码可在文章后查看。



## 目录

* 一、关于Flutter
* 二、代码大致解读
* 三、混合开发
* 总结



## 一、关于Flutter

###1、flutter介绍

Flutter是一个使用Dart语言开发的跨平台移动UI框架,通过自建绘制引擎，能高性能、高保真地进行Android和IOS开发，提供响应式视图而不需要JavaScript桥接器的移动SDK，这就是与和React Native不一样也是优势所在，采用Dart的程序语言来编译避免由JavaScript桥接器引起的性能问题，

#### 开发语言：dart



![1539509311(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/master/readme_images/1539509311(1).jpg)

1. dart具有JIT&AOT双重编译执行方式。这样就能利用JIt进行开发阶段的hot reload开发，提升研发效率。同时在最终release版本中使用aot将dart代码直接变成目标平台的指令集代码。简单高效，最大限度保障了性能，最大限度减少包的大小，目前刚更新flutter preview2.0 对包的大小进一步缩减。
2. dart针对flutter中频繁创建销毁Widget的场景做了专门的gc优化。通过分代无锁垃圾回收器，将gc对性能的影响降至最低。
3. dart语言在语法上面是类java的，易学易用，对于我们原生开发而言  学习JS，Dart语言更能被接受。（个人感觉）

[dart语言的优势详细介绍](http://www.infoq.com/cn/articles/why-flutter-uses-dart)

[Dart语言中文社区-基本语法等介绍](http://www.cndartlang.com/)



### 2、环境配置

[中文配置教程](https://flutterchina.club/setup-windows/)

### 3、flutter特色--你可能会选它的几个理由

1. **热加载**： Flutter 最酷的功能之一，允许你像更新网页一样去实时的更新你的项目。
2. **界面UI风格优美：** UI 全是代码写的而不是 XML。（组件上）并且有丰富的 (Material Design |Cupertino) 组件，实现保持Android 和IOS风格展示一致的效果，Android也可以以IOS风格展示；（主题上） Android/iOS 的不同主题提供api直接判断不同类型，继而展示不同UI 
3. **组件足够小：** Flutter 中的有个核心原则 — **组合优先于继承** 他的每一个基础组件非常细微，所以可以自己组装创建各式各样的组件
4. **后援很强大：**第三方库不断新增中，Flutter开发社区真的很大，而且非常活跃，国内闲鱼已经上线一版，并作为flutter领导者，在前面不断踩坑中；

### 4、美中不足

1. 与RN相比，在性能上和局限性上，可以胜之有余，但是对于在线热更新这个点,目前没有可行的预兆，除非把dart的编译AOT编译放在客户端中，显然是不现实的；虽然，苹果爸爸一直禁用app热更新代码的态度坚决而明确；这个不好评判了
2. 代码上:括号太多了，各种嵌套,代码看起来非常不友好;但是了解其之用法之后，将整个页面分块区分成一个小模块独立，可读性我个人感觉还ok；
3. 毕竟flutter紧跟RN之后才诞生，目前社区，开源方面相对于RN，还不够完善；

### 5、flutter--widget

![1539570669(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/1539570669(1).jpg)

上述图中可以看到：

**Framework**使用dart实现，包括Material Design风格的Widget,Cupertino(针对iOS)风格的Widgets，文本/图片/按钮等基础Widgets，渲染，动画，手势等。此部分的核心代码是:flutter仓库下的flutter package，以及sky_engine仓库下的io,async,ui(dart:ui库提供了Flutter框架和引擎之间的接口)等package。

**Engine**使用C++实现，主要包括:Skia,Dart和Text。Skia是开源的二维图形库；提供了适用于多种软硬件平台的通用API。Dart部分主要包括:Dart Runtime，Garbage Collection(GC)；Text即文本渲染，其渲染层次如下:衍生自minikin的libtxt库(用于字体选择，分隔行)    

虽然深入下去的 暂时还不懂，不难看出widget是我们所能涉及到开发的那一层。Flutter 的核心设计思想便是**Everything’s a Widget** 即一切即Widget。在flutter的世界里，包括views,view controllers,layouts等在内的概念都建立在Widget之上。widget是flutter功能的抽象描述。所以掌握Flutter的基础就是学会使用widget开始。

![1539570893(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/1539570893(1).jpg)

由widget展开的基础组件，布局，交互等；



## 二、代码大致解读

### 1、按照惯例 --- Hello World

~~~
@override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: new Text('Hello World'),
        ),
      ),
    );
  }
} 
~~~

一个 layout 是由嵌套的组件（*Widgets*）构建的， 核心 Widget 是  *MaterialApp* （这是整个的应用程序）， 然后我们有 *Scaffold* （这是我们主界面的 layout 结构），再然后是 *AppBar* （就像 Android `Toolbar`） 和 一些 *Container* 作为 body，在 body 内部，我们可以放置我们 layout 组件 — Texts, Buttons 等等。

### 2、布局

![fef361039bdd30af7dd5a4cab38fbf8](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/fef361039bdd30af7dd5a4cab38fbf8.png)

**1、 布局拆封：**

这是一个简单的计算器页面，很明朗的将整个布局用Colunm竖向排列，Item中的Row再做横向布局，在Flutter 布局中，体现的是横向与竖向的概念 约束方面也是以此为基础 MainAxisAlignment主轴约束（水平X轴）

CrossAxisAlignment副轴约束（竖直Y轴）。在这里说明下，Flutter没有了原来Android的相对布局，但是用它已有的控件，能达到所有需要各种布局约束要求；

​	**吐槽一点：**刚学习这种布局方式，对于约束方法不熟悉，布局很头疼，就像按照格子线去排放不同物品，一点一点挪动，好在热重载，改一行代码就能看见效果

​	收藏一波各类约束布局的控件：SizedOverflowBox，OverflowBox，LimitedBox，FractionallySizedBox，SizedBox & ConstrainedBox，FittedBox，RotatedBox等等；有些控件比较冷门需要自己去慢慢收藏，没用过基本不知道有这样的都已经帮你写好的，能提高不少效率 ；

[按钮控件扩展]([https://zhuanlan.zhihu.com/p/38500192](https://zhuanlan.zhihu.com/p/38500192)�" >，)



**2、State生命周期：**

​	flutter和RN一致，采用响应式视图，维护了一个状态机，只更新改变的最小区域界面	；
​        它有两类widght：

StatelessWidget（无状态）:UI纯展示作用，无交互以及UI变化，例如：提示语等；

StatefulWidget（有状态）:程序运行中，UI发生变化的，以及用户交互的；

![1539603681(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/1539603681(1).jpg)

State的生命周期有四种状态：

* created：当State对象被创建时候，State.initState方法会被调用；
* initialized：当State对象被创建，但还没有准备构建时，State.didChangeDependencies在这个时候会被调用；
* ready：State对象已经准备好了构建，State.dispose没有被调用的时候；
* defunct：State.dispose被调用后，State对象不能够被构建。

调用setState方法后，更新视图，数据改变或者UI需要发生变化，需要再setState方法里对数据源进行更新，然后布局会用新的数据源重新build，

**3、异步-- 网络请求**

常用的`async`  `await` `Future`搭配

~~~
//HTTP的get请求返回值为Future<String>类型，即其返回值未来是一个String类型的值
getData() async {    //async关键字声明该函数内部有代码需要延迟执行
  return await http.get(URL); //await关键字声明运算为延迟执行，然后return运算结果
}
~~~

这时候  如果直接执行 ：

~~~
  String data = getData();
~~~

就直接会报错

![1539745314(1)](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/1539745314(1).jpg)

因为`data`是**String**类型，而函数`getData()`是一个异步操作函数，其返回值是一个`await`延迟执行的结果。在Dart中，有`await`标记的运算，其结果值都是一个`Future`对象，`Future`不是**String**类型，所以就报错了

可以这么实现：

~~~
getData().then(data){
   String _data = data;
}
~~~

`Future` 中`then`API，作用为`getData()`异步执行完成后，在调用`then`方法，并且与`Future` 后面的语句先顺序执行



## 三、混合开发

针对我们目前公版上或者分支上的项目而言，不可能将整个项目移植成Flutter，显然是不现实的。如若是一个新的小项目，我觉得认为这个是可以是个新的尝试，新的技术氛围，也可以衍生或者接触其他的更多领域，有利于增加团队氛围。

当然还有一个尝试：像之前RN一样，独立一些模块功能使用flutter开发，将这些独立模块使用类似SDK形式，引入我们的项目中，开放出接口给Native调用；

问题：由Flutter目录再分别包含Native工程的目录（即ios和android两个目录）组成。默认情况下，引入了Flutter的Native工程无法脱离父目录进行独立构建和运行，因为它会反向依赖于Flutter相关的库和资源

![qqqq](https://raw.githubusercontent.com/PorterKing/flutter_app/raw/readme_images/qqqq.png)

[闲鱼针对项目混合开发改造实践](https://juejin.im/post/5b3f098ce51d45199840f4bb)

## 总结

Dart语言，运用起来，函数思想与kotlin类似，Dart语言上的特性，kotlin都有，唯一算的上特点就是Dart编译速度快了。面对对象的思想，和java如出一辙，我学起来倒也不是很吃力。对于编写代码来讲，槽点就是他的代码风格，括号嵌套太多，每个组件后，以“，”结尾，这样格式化稍微好一些；

Flutter官方吹的很大，说它是革命性的，也有一定道理。但是我觉得RN对于熟悉web开发的人来说，是更好的选择。但是对于纯native开发的移动开发人员，直接学习Flutter会更好，Flutter也比较适合本来就是做native开发的人
目前，Flutter还是处于beta版本，尽管如此，现在闲鱼也已经作为大头，在前面领路了。作为Google亲儿子，相信Flutter 不会像RN一样，路途那么坎坷

## 官方资源

1、[Flutter官网](https://flutter.io/)

2、[Flutter快速入门](https://flutter.io/get-started/install/)

3、[Flutter—API 文档](https://flutter.io/docs/)

4、[Github](https://github.com/flutter/flutter)

5、[Google+网上论坛](https://groups.google.com/forum/#!forum/flutter-dev)

6、[Twitter](https://twitter.com/flutterio)

7、[Gitter](https://gitter.im/flutter/flutter)

8、[Flutter技术周报](https://flutterweekly.net/)



  
