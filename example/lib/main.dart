import 'package:flutter/material.dart';
import 'package:xtw_mob/xtw.dart';
import 'package:xtw_mob_example/pages/banner_page.dart';
import 'package:xtw_mob_example/pages/feed_page.dart';
import 'package:xtw_mob_example/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final isInited = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    print(await XTWAd.initAd('881'));
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Widget> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView(
        children: [
          ...events,
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('横幅广告'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BannerPage(),
                ),
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('开屏广告'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashPage(),
                ),
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('信息流广告'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedPage(),
                ),
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('插屏广告'),
            onPressed: () async {
              setState(() {
                events = [];
              });
              XTWAd.insertAd(
                '11087',
                callback: XTWCallback(
                  onShow: () {
                    setState(() {
                      events.add(Text('插屏广告 onShow'));
                    });
                  },
                  onClick: () {
                    setState(() {
                      events.add(Text('插屏广告 onClick'));
                    });
                  },
                  onClose: () {
                    setState(() {
                      events.add(Text('插屏广告 onClose'));
                    });
                  },
                  onFail: () {
                    setState(() {
                      events.add(Text('插屏广告 onFail'));
                    });
                  },
                ),
              );
            },
          ),
          MaterialButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: const Text('激励广告'),
            onPressed: () async {
              setState(() {
                events = [];
              });
              XTWAd.rewardAd(
                '1028',
                userId: 'userId',
                callback: XTWCallback(
                  onShow: () {
                    setState(() {
                      events.add(Text('激励广告 onShow'));
                    });
                  },
                  onClick: () {
                    setState(() {
                      events.add(Text('激励广告 onClick'));
                    });
                  },
                  onClose: () {
                    setState(() {
                      events.add(Text('激励广告 onClose'));
                    });
                  },
                  onFail: () {
                    setState(() {
                      events.add(Text('激励广告 onFail'));
                    });
                  },
                  onSkip: () {
                    setState(() {
                      events.add(Text('激励广告 onSkip'));
                    });
                  },
                  onReward: () {
                    setState(() {
                      events.add(Text('激励广告 onReward'));
                    });
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
