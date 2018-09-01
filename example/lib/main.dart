import 'package:flutter/material.dart';
import 'package:scale_page_view/scale_page_view.dart';

void main() {
  MaterialPageRoute.debugEnableFadingRoutes = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildItem(String name, WidgetBuilder builder) {
    return new ListTile(
      title: new GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: builder));
        },
        child: new Text(name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ScalePageView"),
        elevation: 0.5,
      ),
      body: new ListView(
        children: <Widget>[
          new Divider(),
          _buildItem("Example1 Image Page View", (context) {
            return new Example1();
          }),
          new Divider(),
          _buildItem("Example2 Text Page View", (context) {
            return new Example2();
          }),
          new Divider(),
        ],
      ),
    );
  }
}

const double _kBar1Height = 300.0;
const double _kBar2Height = 100.0;

List<Widget> images = [
  new Image.network(
    "https://petbird.tw/wp-content/uploads/2013/06/pet105.jpg",
  ),
  new Image.network(
    "https://petbird.tw/wp-content/uploads/2013/06/pet105.jpg",
  ),
  new Image.network(
    "https://petbird.tw/wp-content/uploads/2013/06/pet105.jpg",
  ),
  new Image.network(
    "https://petbird.tw/wp-content/uploads/2013/06/pet105.jpg",
  ),
  new Image.network(
    "https://petbird.tw/wp-content/uploads/2013/06/pet105.jpg",
  ),
];

Widget _buildBackground(Color leftColor, Color rightColor) {
  return new Container(
    decoration: new BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          leftColor,
          rightColor,
        ],
      ),
    ),
  );
}

List<Widget> backgrounds = [
  _buildBackground(const Color(0xFF3B5F8F), const Color(0xFF8266D4)),
  _buildBackground(const Color(0xFF8266D4), const Color(0xFFF95B57)),
  _buildBackground(const Color(0xFFF95B57), const Color(0xFFF3A646)),
  _buildBackground(const Color(0xFFF3A646), const Color(0xFF3B5F8F)),
  _buildBackground(const Color(0xFF3B5F8F), const Color(0xFF8266D4)),
];
const TextStyle sectionTitleStyle = const TextStyle(
  fontFamily: 'Raleway',
  inherit: false,
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  textBaseline: TextBaseline.alphabetic,
);
List<String> texts = [
  "西伯利亚雪橇犬",
  "西伯利亚雪橇犬",
  "西伯利亚雪橇犬",
  "西伯利亚雪橇犬",
  "西伯利亚雪橇犬",
];
List<String> descs = [
  "       西伯利亚雪橇犬（俄语：Сибирский хаски，英语：Siberian husky），常见别名哈士奇，昵称为二哈。西伯利亚雪橇犬体重介于雄犬20-27公斤，雌犬16-23公斤，身高大约雄犬肩高53-58厘米，雌犬51-56厘米，是一种中型犬。\n       西伯利亚雪橇犬是原始的古老犬种，在西伯利亚东北部、格陵兰南部生活。哈士奇名字的由来，是源自其独特的嘶哑声。哈士奇性格多变，有的极端胆小，也有的极端暴力，进入大陆和家庭的哈士奇，都已经没有了这种极端的性格，比较温顺，是一种流行于全球的宠物犬。与金毛犬、拉布拉多并列为三大无攻击型犬类。被世界各地广泛饲养，并在全球范围内，有大量该犬种的赛事。",
  "       西伯利亚雪橇犬（俄语：Сибирский хаски，英语：Siberian husky），常见别名哈士奇，昵称为二哈。西伯利亚雪橇犬体重介于雄犬20-27公斤，雌犬16-23公斤，身高大约雄犬肩高53-58厘米，雌犬51-56厘米，是一种中型犬。\n       西伯利亚雪橇犬是原始的古老犬种，在西伯利亚东北部、格陵兰南部生活。哈士奇名字的由来，是源自其独特的嘶哑声。哈士奇性格多变，有的极端胆小，也有的极端暴力，进入大陆和家庭的哈士奇，都已经没有了这种极端的性格，比较温顺，是一种流行于全球的宠物犬。与金毛犬、拉布拉多并列为三大无攻击型犬类。被世界各地广泛饲养，并在全球范围内，有大量该犬种的赛事。",
  "       西伯利亚雪橇犬（俄语：Сибирский хаски，英语：Siberian husky），常见别名哈士奇，昵称为二哈。西伯利亚雪橇犬体重介于雄犬20-27公斤，雌犬16-23公斤，身高大约雄犬肩高53-58厘米，雌犬51-56厘米，是一种中型犬。\n       西伯利亚雪橇犬是原始的古老犬种，在西伯利亚东北部、格陵兰南部生活。哈士奇名字的由来，是源自其独特的嘶哑声。哈士奇性格多变，有的极端胆小，也有的极端暴力，进入大陆和家庭的哈士奇，都已经没有了这种极端的性格，比较温顺，是一种流行于全球的宠物犬。与金毛犬、拉布拉多并列为三大无攻击型犬类。被世界各地广泛饲养，并在全球范围内，有大量该犬种的赛事。",
  "       西伯利亚雪橇犬（俄语：Сибирский хаски，英语：Siberian husky），常见别名哈士奇，昵称为二哈。西伯利亚雪橇犬体重介于雄犬20-27公斤，雌犬16-23公斤，身高大约雄犬肩高53-58厘米，雌犬51-56厘米，是一种中型犬。\n       西伯利亚雪橇犬是原始的古老犬种，在西伯利亚东北部、格陵兰南部生活。哈士奇名字的由来，是源自其独特的嘶哑声。哈士奇性格多变，有的极端胆小，也有的极端暴力，进入大陆和家庭的哈士奇，都已经没有了这种极端的性格，比较温顺，是一种流行于全球的宠物犬。与金毛犬、拉布拉多并列为三大无攻击型犬类。被世界各地广泛饲养，并在全球范围内，有大量该犬种的赛事。",
  "       西伯利亚雪橇犬（俄语：Сибирский хаски，英语：Siberian husky），常见别名哈士奇，昵称为二哈。西伯利亚雪橇犬体重介于雄犬20-27公斤，雌犬16-23公斤，身高大约雄犬肩高53-58厘米，雌犬51-56厘米，是一种中型犬。\n       西伯利亚雪橇犬是原始的古老犬种，在西伯利亚东北部、格陵兰南部生活。哈士奇名字的由来，是源自其独特的嘶哑声。哈士奇性格多变，有的极端胆小，也有的极端暴力，进入大陆和家庭的哈士奇，都已经没有了这种极端的性格，比较温顺，是一种流行于全球的宠物犬。与金毛犬、拉布拉多并列为三大无攻击型犬类。被世界各地广泛饲养，并在全球范围内，有大量该犬种的赛事。",
];

class Example1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Example1State();
  }
}

/// Use State,avoid reinitializing variables because of refresh
class Example1State extends State<Example1> {
  final PageController _pageController = new PageController();
  final PageController _tabController = new PageController();

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new Container(
              height: _kBar1Height,
              child: new ScalePageView(
                controller: _tabController,
                children: images,
                pageTapChange: true,
//              backgrounds: backgrounds,
                onPageChanging: (value) {
                  if (_pageController.position.pixels != value) {
                    _pageController.position.jumpToWithoutSettling(value);
                  }
                },
                onCurrentTabTap: (index){
                  debugPrint("touch $index");
                },
                indicatorColor: Colors.white,
                pageRatio: 0.7,
                scaleRatio: 0.1,
                indicator: false,
                onPageChange: (index) {},
              )),
          new Expanded(
              child: new NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (_tabController.position.pixels !=
                          _pageController.position.pixels) {
                        _tabController.position.jumpToWithoutSettling(
                            _pageController.position.pixels);
                      }
                    }
                  },
                  child: new PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return new Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: new SingleChildScrollView(
                            child: new Column(
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      texts[index],
                                      style: new TextStyle(
                                          fontSize: 23.0,
                                          color: Color(0xff333333)),
                                    )
                                  ],
                                ),
                                new Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: new RichText(
                                    text: new TextSpan(
                                        text: descs[index],
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xff999999))),
                                  ),
                                )
                              ],
                            ),
                          ));
                    },
                    itemCount: images.length,
                  )))
        ],
      ),
    );
  }
}

class Example2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Example2State();
  }
}

class Example2State extends State<Example2> {
  final PageController _pageController = new PageController();
  final PageController _tabController = new PageController();

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Column(
        children: <Widget>[
          new Container(
              height: _kBar2Height,
              child: new ScalePageView(
                controller: _tabController,
                children: texts.map((String text) {
                  return new Text(
                    text,
                    style: sectionTitleStyle,
                  );
                }).toList(),
                backgrounds: backgrounds,
                onPageChanging: (value) {
                  if (_pageController.position.pixels != value) {
                    _pageController.position.jumpToWithoutSettling(value);
                  }
                },
                indicatorColor: Colors.white,
                pageRatio: 0.5,
                scaleRatio: 0.3,
                indicator: true,
                onPageChange: (index) {},
              )),
          new Expanded(
              child: new NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (_tabController.position.pixels !=
                          _pageController.position.pixels) {
                        _tabController.position.jumpToWithoutSettling(
                            _pageController.position.pixels);
                      }
                    }
                  },
                  child: new PageView.builder(
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return new Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20.0),
                        child: new SingleChildScrollView(
                          child: new Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: images[index],
                              ),
                              new Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: new RichText(
                                  text: new TextSpan(
                                      text: descs[index],
                                      style: new TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xff999999))),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: images.length,
                  )))
        ],
      ),
    );
  }
}
