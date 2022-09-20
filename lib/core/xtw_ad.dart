import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xtw_mob/core/constant.dart';
import 'package:xtw_mob/core/stream_handler.dart';
import 'package:xtw_mob/core/xtw_callback.dart';

class XTWAd {
  XTWAd._();

  static const MethodChannel _methodChannel =
      MethodChannel(Constant.methodChannel);

  static Future<bool> initAd(String appId) async {
    return await _methodChannel.invokeMethod('initAd', {"id": appId});
  }

  static void insertAd(String adCode, {XTWCallback? callback}) {
    late final StreamSubscription streamSubscription;
    streamSubscription = StreamHandler.listen(
        insertAdCallBack: XTWCallback(
      onClick: callback?.onClick,
      onShow: callback?.onShow,
      onClose: () {
        callback?.onClose?.call();
        streamSubscription.cancel();
      },
      onFail: () {
        callback?.onFail?.call();
        streamSubscription.cancel();
      },
    ));
    _methodChannel.invokeMethod('insertAd', {"id": adCode});
  }

  static void rewardAd(
    String adCode, {
    required String userId,
    XTWCallback? callback,
  }) {
    late final StreamSubscription streamSubscription;
    streamSubscription = StreamHandler.listen(
        rewardAdCallbck: XTWCallback(
      onClick: callback?.onClick,
      onShow: callback?.onShow,
      onClose: () {
        callback?.onClose?.call();
        streamSubscription.cancel();
      },
      onFail: () {
        callback?.onFail?.call();
        streamSubscription.cancel();
      },
      onReward: callback?.onReward,
    ));
    _methodChannel.invokeMethod('rewardAd', {
      "id": adCode,
      "userId": userId,
    });
  }
}
