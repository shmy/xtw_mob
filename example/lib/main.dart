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

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: ListView(
        children: [
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
              XTWAd.insertAd(
                '11087',
                callback: XTWCallback(
                  onShow: () {
                    print('插屏广告 onShow');
                  },
                  onClick: () {
                    print('插屏广告 onClick');
                  },
                  onClose: () {
                    print('插屏广告 onClose');
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
              XTWAd.rewardAd(
                '1028',
                userId: 'userId',
                callback: XTWCallback(
                  onShow: () {
                    print('激励广告 onShow');
                  },
                  onClick: () {
                    print('激励广告 onClick');
                  },
                  onClose: () {
                    print('激励广告 onClose');
                  },
                  onReward: () {
                    print('激励广告 onReward');
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
