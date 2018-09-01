library scale_page_view;

import 'package:flutter/material.dart';
import 'dart:math' as math;
const double kPageIndicatorWidth = 32.0;

class ScalePageView extends StatefulWidget {
  ScalePageView(
      {Key key,
      this.controller,
      @required this.children,
      this.onPageChanging,
      this.onPageChange,
      this.backgrounds,
      this.background,
      this.indicator: true,
      this.indicatorColor: Colors.black,
      this.pageTapChange: true,
      this.pageRatio: 0.5,
      this.scaleRatio: 0.2,
      this.opacityRatio: 0.5,
      this.paddingTB: 23.0,
      this.physics,
      this.onCurrentTabTap})
      : assert(children != null && children.length > 0),
        assert(pageRatio <= 1.0 && pageRatio > 0),
        assert(scaleRatio <= 1.0 && scaleRatio > 0),
        assert(opacityRatio <= 1.0 && opacityRatio > 0),
        assert(background == null || backgrounds == null),
        super(key: key);

  final List<Widget> children;
  final ValueChanged<double> onPageChanging;
  final ValueChanged<int> onPageChange;
  final List<Widget> backgrounds;
  final PageController controller;
  final Widget background;
  final bool indicator;
  final Color indicatorColor;
  final bool pageTapChange;

  final double pageRatio;
  final double scaleRatio;
  final double opacityRatio;
  final double paddingTB;
  final ScrollPhysics physics;
  final ValueChanged<int> onCurrentTabTap;

  @override
  State<StatefulWidget> createState() {
    return new ScalePageViewState();
  }
}

class ScalePageViewState extends State<ScalePageView> {
  PageController _pageController;
  ValueNotifier<double> selectedIndex = new ValueNotifier(0.0);
  List<Widget> backgrounds;

  /// 在使用Key调用该处的时候,切记不能在最外层使用StatelessWidget
  /// 这样可能会时Key发生变化,然后造成State重建
  /// The purpose of a stateful widget is that they don't recreate their state object every time
  /// they are built - otherwise they would be the same as a regular Widget.
  /// A state object is recreated if the widget's runtimeType or key is different.
  /// Otherwise the lifecycle didUpdateWidget is used to notify the State object that the configuration changed.
  @Deprecated('This will lead to bugs.')
  void jumpToWithoutSettling(double value) {
    if (_pageController.position.pixels != value) {
      _pageController.position.jumpToWithoutSettling(value);
    }
  }

  bool _handlePageNotification(ScrollNotification notification) {
    if (notification.depth == 0 && notification is ScrollUpdateNotification) {
      selectedIndex.value = _pageController.page;
      if (widget.onPageChanging != null) {
        widget.onPageChanging(_pageController.position.pixels);
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _pageController = widget.controller ?? new PageController();
    backgrounds = widget.backgrounds ?? [];
    if (backgrounds.length == 0) {
      Widget background = widget.background ??
          new Container(
            color: Colors.white,
          );
      for (int i = 0; i < widget.children.length; i++) {
        backgrounds.add(background);
      }
    }
  }

  Iterable<Widget> _allItems(List<Widget> pages) {
    final List<Widget> headings = <Widget>[];
    for (int index = 0; index < pages.length; index++) {
      headings.add(new Container(
        child: new ClipRect(
          child: new _AllPagesView(
            sectionIndex: index,
            selectedIndex: selectedIndex,
            pages: pages,
            backgrounds: backgrounds,
            pageTapChange: widget.pageTapChange,
            indicator: widget.indicator,
            indicatorColor: widget.indicatorColor,
            pageRatio: widget.pageRatio,
            scaleRatio: widget.scaleRatio,
            opacityRatio: widget.opacityRatio,
            paddingTB: widget.paddingTB,
            onTabTap: (index) {
              if (index == _pageController.page.ceil() && widget.onCurrentTabTap != null) {
                widget.onCurrentTabTap(index);
              } else if (widget.pageTapChange) {
                _pageController.animateToPage(index,
                    duration: new Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              }
            },
          ),
        ),
      ));
    }
    return headings;
  }

  @override
  Widget build(BuildContext context) {
    return new NotificationListener(
        onNotification: _handlePageNotification,
        child: new PageView(
          controller: _pageController,
          children: _allItems(widget.children),
          onPageChanged: widget.onPageChange,
          physics: widget.physics,
        ));
  }
}

class _AllPagesView extends AnimatedWidget {
  _AllPagesView(
      {Key key,
      this.sectionIndex,
      @required this.selectedIndex,
      @required this.pages,
      this.backgrounds,
      this.onTabTap,
      this.pageTapChange,
      this.pageTapOffset,
      this.indicator,
      this.indicatorColor,
      this.pageRatio,
      this.scaleRatio,
      this.opacityRatio,
      this.paddingTB})
      : assert(selectedIndex != null),
        assert(selectedIndex.value >= 0.0 &&
            selectedIndex.value < pages.length.toDouble()),
        assert(backgrounds == null || backgrounds.length == pages.length),
        super(key: key, listenable: selectedIndex);

  final int sectionIndex;
  final ValueNotifier<double> selectedIndex;
  final List<Widget> pages;
  final List<Widget> backgrounds;
  final ValueChanged<int> onTabTap;
  final bool pageTapChange;
  final double pageTapOffset;
  final bool indicator;
  final Color indicatorColor;
  final double pageRatio;
  final double scaleRatio;
  final double opacityRatio;
  final double paddingTB;

  double _selectedIndexDelta(int index) {
    return (index.toDouble() - selectedIndex.value).abs().clamp(0.0, 1.0);
  }

  /// calculate page and indicator opacity or scale
  /// when the index equal current page, will return 1.0
  double _calculateScale(int index) {
    return 1.0 - _selectedIndexDelta(index) * scaleRatio;
  }

  double _calculateOpacity(int index) {
    return 1.0 - _selectedIndexDelta(index) * opacityRatio;
  }

  void changePage(TapUpDetails details, double width, int index) {
    if (pageTapChange && onTabTap != null) {
      final double xOffset = details.globalPosition.dx;
      final double centerX = width / 2.0;
      int newPageIndex = index;
      if (xOffset - centerX > pageTapOffset &&
          newPageIndex < pages.length - 1) {
        newPageIndex++;
      } else if (centerX - xOffset > pageTapOffset && newPageIndex > 0) {
        newPageIndex--;
      }
      onTabTap(newPageIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (context, size) {
      final List<Widget> children = [];
      // put all the backgrounds at the bottom
      for (int index = 0; index < pages.length; index++) {
        children.add(new LayoutId(
          id: 'bg$index',
          child: new GestureDetector(
              behavior: HitTestBehavior.opaque,
//              onTapUp: (TapUpDetails details) {
//                changePage(details, size.maxWidth, index);
//              },
              child: new Container(
                child: backgrounds == null ? null : backgrounds[index],
              )),
        ));
      }
      for (int index = 0; index < pages.length; index++) {
        children.add(new LayoutId(
          id: 'page$index',
          child: new GestureDetector(
            onTapUp: (TapUpDetails details) {
              if (onTabTap != null) {
                onTabTap(index);
              }
            },
            child: new _PageWrapper(
                child: pages[index],
                scale: _calculateScale(index),
                opacity: _calculateOpacity(index)),
          ),
        ));
        if (indicator) {
          children.add(new LayoutId(
            id: 'indicator$index',
            child: new _PageIndicator(
              opacity: _calculateOpacity(index),
              color: indicatorColor,
            ),
          ));
        }
      }
      return new CustomMultiChildLayout(
        delegate: new _AllPagesLayout(
            translation: new Alignment(
                (selectedIndex.value - sectionIndex) * 2.0 - 1.0, -1.0),
            selectedIndex: selectedIndex.value,
            pageRatio: pageRatio,
            pageCount: pages.length,
            paddingTB: paddingTB),
        children: children,
      );
    });
  }
}

class _AllPagesLayout extends MultiChildLayoutDelegate {
  _AllPagesLayout(
      {this.translation,
      this.selectedIndex,
      this.pageCount,
      this.pageRatio,
      double paddingTB})
      : padding = paddingTB * 2;

  final Alignment translation;
  final double selectedIndex;
  final int pageCount;
  final double pageRatio;
  final double padding;

  @override
  void performLayout(Size size) {
    assert(size.height > padding);
    final double itemWidth = size.width;
    final double itemHeight = size.height;
    // 计算在当前位置下的offset,其主要作用是利用Alignment,使得item进行相应的偏移
    // 因为titleWidth和itemWidth不一致,需要用这个达到减缓位移速度的效果,最终使得title还是在中间
    // 用来抵消掉由于pageView移动产生的影响
    final Offset offset = translation.alongSize(size);
    double itemX = -(selectedIndex * itemWidth);

    final double pageAreaWidth = pageRatio * itemWidth;
    double itemPageAreaX =
        (size.width - pageAreaWidth) / 2.0 - selectedIndex * pageAreaWidth;

    final double indicatorAreaWidth = pageAreaWidth;

    // 最后的减法是用来产生移动的
    double itemIndicatorAreaX = (size.width - indicatorAreaWidth) / 2.0 -
        selectedIndex * indicatorAreaWidth;

    for (int index = 0; index < pageCount; index++) {
      final Rect itemRect =
          new Rect.fromLTWH(itemX, 0.0, itemWidth, itemHeight);
      final Rect pageAreaRect = new Rect.fromLTWH(
          itemPageAreaX, 0.0, pageAreaWidth, itemHeight - padding);
      // layout background
      layoutChild('bg$index', new BoxConstraints.tight(itemRect.size));
      positionChild('bg$index', itemRect.topLeft + offset);

      // layout title
      final Size pageSize = layoutChild(
          'page$index', new BoxConstraints.loose(pageAreaRect.size));
      final double pageY = itemRect.centerLeft.dy - pageSize.height / 2.0;
      final double pageX =
          itemPageAreaX + (pageAreaWidth - pageSize.width) / 2.0;
      final Offset pageOrigin = new Offset(pageX, pageY);
      positionChild('page$index', pageOrigin + offset);

      // layout indicator
      if (hasChild('indicator$index')) {
        final Size indicatorSize = layoutChild(
            'indicator$index', new BoxConstraints.loose(pageAreaRect.size));
        final Rect pageRect =
            new Rect.fromPoints(pageOrigin, pageSize.bottomRight(pageOrigin));

        // 使得indicator在title正下方
        final double indicatorY = pageRect.bottomCenter.dy + 14.0;
        final double indicatorX = itemIndicatorAreaX +
            (indicatorAreaWidth - indicatorSize.width) / 2.0;

        final Offset indicatorOrigin = new Offset(indicatorX, indicatorY);
        positionChild('indicator$index', indicatorOrigin + offset);
      }

      itemX += itemWidth;
      itemPageAreaX += pageAreaWidth;
      itemIndicatorAreaX += indicatorAreaWidth;
    }
  }

  @override
  bool shouldRelayout(_AllPagesLayout oldDelegate) {
    return pageCount != oldDelegate.pageCount ||
        selectedIndex != oldDelegate.selectedIndex;
  }
}

class _PageWrapper extends StatelessWidget {
  const _PageWrapper({
    Key key,
    @required this.child,
    @required this.scale,
    @required this.opacity,
  })  : assert(child != null),
        assert(scale != null),
        assert(opacity != null && opacity >= 0.0 && opacity <= 1.0),
        super(key: key);

  final Widget child;
  final double scale;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Opacity(
        opacity: opacity,
        child: new Transform(
          transform: new Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({Key key, this.opacity: 1.0, this.color: Colors.white})
      : super(key: key);

  final double opacity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new IgnorePointer(
      child: new Container(
        width: kPageIndicatorWidth,
        height: 3.0,
        color: color.withOpacity(opacity),
      ),
    );
  }
}
