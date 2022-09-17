import 'package:flutter/material.dart';
import 'package:xtw_mob/view/xtw_feed_view.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: XTWFeedView(
              placeholder: (BuildContext context) {
                return Container(
                    color: Colors.red, child: const Center(child: FlutterLogo()));
              },
              height: 200,
              width: MediaQuery.of(context).size.width,
              adCode: '2351',
            ),
          ),
        ],
      ),
    );
  }
}
