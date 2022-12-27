import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:xtw_mob/core/constant.dart';
import 'package:xtw_mob/core/xtw_callback.dart';

class XTWAd {
  XTWAd._();

  static bool isAndroid = Platform.isAndroid;

  static const MethodChannel _methodChannel =
      MethodChannel(Constant.methodChannel);

  static Future<bool> initAd(String appId) async {
    return await _methodChannel.invokeMethod('initAd', {"id": appId});
  }

  static Future<void> insertAd(String adCode, {XTWCallback? callback}) async {
    if (!isAndroid) {
      callback?.onClose?.call();
      return;
    }
    final id = await _methodChannel.invokeMethod('insertAd', {
      "id": adCode,
    });
    late final StreamSubscription sub;
    sub = EventChannel("insertAdEvent_$id")
        .receiveBroadcastStream()
        .listen((event) {
      _listenter(event, sub, callback: callback);
    });
  }

  static Future<void> rewardAd(
    String adCode, {
    required String userId,
    XTWCallback? callback,
  }) async {
    if (!isAndroid) {
      callback?.onReward?.call();
      return;
    }
    final id = await _methodChannel.invokeMethod('rewardAd', {
      "id": adCode,
      "userId": userId,
    });
    late final StreamSubscription sub;
    sub = EventChannel("rewardAdEvent_$id")
        .receiveBroadcastStream()
        .listen((event) {
      _listenter(event, sub, callback: callback);
    });
  }

  static void _listenter(event, StreamSubscription sub,
      {XTWCallback? callback}) {
    switch (event['event']) {
      case 'onShow':
        callback?.onShow?.call();
        break;
      case 'onClick':
        callback?.onClick?.call();
        break;
      case 'onError':
        callback?.onFail?.call();
        sub.cancel();
        break;
      case 'onSkip':
        callback?.onSkip?.call();
        break;
      case 'onDismiss':
        callback?.onClose?.call();
        sub.cancel();
        break;
      case 'onReward':
        callback?.onReward?.call();
        break;
      default:
        break;
    }
  }
}
