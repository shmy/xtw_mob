import 'dart:async';

import 'package:flutter/services.dart';
import 'package:xtw_mob/core/constant.dart';
import 'package:xtw_mob/core/xtw_callback.dart';

const EventChannel _eventChannel = EventChannel(Constant.eventChannel);

class StreamHandler {
  StreamHandler._();

  static StreamSubscription listen({
    XTWCallback? insertAdCallBack,
    XTWCallback? rewardAdCallbck,
  }) {
    StreamSubscription streamSubscription =
        _eventChannel.receiveBroadcastStream().listen((data) {
      switch (data['type']) {
        case Constant.insertAd:
          _processingCallbck(insertAdCallBack, data);
          break;
        case Constant.rewardAd:
          _processingCallbck(rewardAdCallbck, data);
          break;
      }
    });
    return streamSubscription;
  }

  static void _processingCallbck(XTWCallback? callBack, dynamic event) {
    switch (event['event']) {
      case 'onShow':
        callBack?.onShow?.call();
        break;
      case 'onClick':
        callBack?.onClick?.call();
        break;
      case 'onError':
        callBack?.onFail?.call();
        break;
      case 'onDismiss':
        callBack?.onClose?.call();
        break;
      case 'onReward':
        callBack?.onReward?.call();
        break;
      default:
        break;
    }
  }
}
