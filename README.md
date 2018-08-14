# ScalePageView 
![](https://img.shields.io/badge/license-GPL-orange.svg)

一个将相邻的Page进行缩放到同一个屏显示的控件,可以用来做以下用途:
1. 图片浏览
2. 单页的 Tab
3. 添加作为PageView标题栏
4. (**TODO**) 可以修改加入无限滚动和轮播功能,变成轮播图

### 效果图
<img src="http://qiniu.inrush.me/2018-08-14-imageDemo.png" width=286 />
<img src="http://qiniu.inrush.me/2018-08-14-textImage.png" width=286 />
> 第一张图是将图片进行分页
> 第二张图是将文字进行分页 
 
### GIF 
> 可能会有点卡,GitHub显示不出来,可以到这里看[gif](http://qiniu.inrush.me/ScalePageView.gif)

![](http://qiniu.inrush.me/ScalePageView.gif)
### 使用

``` dart
可用属性:
/// PageController
controller,
/// Page children
@required this.children,
/// type: ValueChanged<double> 
/// 页面滚动时触发,接收参数为 pageController.position.pixels
onPageChanging,
/// type: ValueChanged<int>
/// 页面变化时触发,接收的参数为改变后的新页面
onPageChange,
/// type: List<Widget>
/// 每一页的背景,length 必须等于 children.length
backgrounds,
/// type: Widget
/// 统一设置每一页的背景
background,
/// 设置是否显示指示器
indicator: true,
/// 设置指示器的颜色
indicatorColor: Colors.black,
/// 相邻的Page点击的时候是否要跳转
pageTapChange: true,
/// 在相邻的两页很远的时候,点击离中心 offset 这么远的时候,
/// 跳转对应页面
pageTapOffset: 60.0,
/// 当前页占屏幕宽度比例
pageRatio: 0.5,
/// 相邻页面的缩放比,影响页面之间的间距
scaleRatio: 0.2,
/// 相邻页面的不透明度
opacityRatio: 0.5,
/// 上下的Padding
paddingTB: 23.0

new Container(
    height: 200.0,
    child: new ScalePageView(
        key: _pageKey,
        children: images,
        backgrounds: backgrounds,
        onPageChanging: (value) {
            if (_pageController.position.pixels != value) {
                // _pageController 为另外一个PageView的Controller
                // 这样可以使ScalePageView移动的时候,另外一个PageView跟着动
                // 若要两个联动,可在另外一个PageView中添加NotificationListener,
                // 监听另外一个PageView滚动,然后通过GlobalKey<ScalePageViewState>,即上面设置的_pageKey,
                // 调用 _pageKey.currentState.jumpToWithoutSettling(
                // _pageController.position.pixels) 进行联动
                // 详细的实现请看 example 中的例子
                 _pageController.position.jumpToWithoutSettling(value);
            }
        },
        indicatorColor: Colors.white,
        pageRatio: 0.7,
        scaleRatio: 0.1,
        indicator: false,
        onPageChange: (index) {},
))
```
### 主要特性
1. 在一屏中可以看到相邻两屏的内容
2. 可以设置Widget作为背景
3. 可以设置一屏的占比,相邻两屏的透明度以及缩放比
4. 可以和其他PageView进行联动
5. 内置一个横线作为指示器

### TODO
1. 设置无限循环滚动
2. 加入轮播功能,可替代作为轮播图

### 参考
[Official Example - Flutter Gallery](https://github.com/flutter/flutter/tree/master/examples/flutter_gallery)
[Realank/flutter_card_navi](https://github.com/Realank/flutter_card_navi)

