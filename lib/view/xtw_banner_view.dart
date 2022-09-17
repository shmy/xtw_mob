import 'package:flutter/material.dart';
import 'package:xtw_mob/core/constant.dart';
import 'package:xtw_mob/core/xtw_callback.dart';
import 'package:xtw_mob/view/xtw_view.dart';

class XTWBannerView extends XTWView {
  final String adCode;
  final double width;
  final double height;
  final XTWCallback? callback;
  final WidgetBuilder? placeholder;

  const XTWBannerView({
    Key? key,
    required this.adCode,
    required this.width,
    required this.height,
    this.callback,
    this.placeholder,
  }) : super(
          key: key,
          adCode: adCode,
          viewType: Constant.bannerAdView,
          width: width,
          height: height,
          callback: callback,
          placeholder: placeholder,
        );
}
