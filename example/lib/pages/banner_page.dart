import 'package:flutter/material.dart';
import 'package:xtw_mob/xtw.dart';

class BannerPage extends StatelessWidget {
  const BannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Banner"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            child: XTWBannerView(
              placeholder: (BuildContext context) {
                return Container(
                    color: Colors.red, child: const Center(child: FlutterLogo()));
              },
              height: 100,
              width: MediaQuery.of(context).size.width,
              adCode: '1983',
            ),
          ),
          Container(
            color: Colors.black,
            child: XTWBannerView(
              placeholder: (BuildContext context) {
                return Container(
                    color: Colors.red, child: const Center(child: FlutterLogo()));
              },
              height: 100,
              width: MediaQuery.of(context).size.width,
              adCode: '1983',
            ),
          ),
        ],
      ),
    );
  }
}
