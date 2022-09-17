import 'package:flutter/material.dart';
import 'package:xtw_mob/xtw.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return XTWSplashView(
      placeholder: (BuildContext context) {
        return Container(
            color: Colors.red, child: const Center(child: FlutterLogo()));
      },
      adCode: '3561',
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      callback: XTWCallback(
        onFail: () {
          _onEnd(context);
        },
        onClick: () {
          _onEnd(context);
        },
        onClose: () {
          _onEnd(context);
        },
      ),
    );
  }

  void _onEnd(BuildContext context) {
    Navigator.of(context).pop();
  }
}
