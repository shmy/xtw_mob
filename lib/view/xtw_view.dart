import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xtw_mob/core/xtw_callback.dart';

class XTWView extends StatefulWidget {
  final String adCode;
  final String viewType;
  final double width;
  final double height;
  final XTWCallback? callback;
  final WidgetBuilder? placeholder;

  const XTWView({
    Key? key,
    required this.adCode,
    required this.viewType,
    required this.width,
    required this.height,
    this.callback,
    this.placeholder,
  }) : super(key: key);

  @override
  State<XTWView> createState() => _XTWViewState();
}

class _XTWViewState extends State<XTWView> {
  String get viewType => widget.viewType;
  MethodChannel? _methodChannel;
  bool isExposed = false;
  bool isDismissed = false;

  @override
  void dispose() {
    _methodChannel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isDismissed) {
      return const SizedBox();
    }
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          if (widget.placeholder != null && !isExposed)
            Positioned.fill(
              child: widget.placeholder!.call(context),
            ),
          Positioned.fill(
            key: const Key('XTWView'),
            child: SafeArea(
              child: Builder(builder: (BuildContext context) {
                final Map<String, dynamic> creationParams = <String, dynamic>{
                  "id": widget.adCode,
                  "width": widget.width,
                  "height": widget.height,
                };
                if (Platform.isAndroid) {
                  return AndroidView(
                    viewType: viewType,
                    creationParams: creationParams,
                    layoutDirection: TextDirection.ltr,
                    creationParamsCodec: const StandardMessageCodec(),
                    onPlatformViewCreated: _registerChannel,
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _registerChannel(int id) {
    _methodChannel = MethodChannel("${viewType}_$id");
    _methodChannel?.setMethodCallHandler(_platformCallHandler);
  }

  Future<dynamic> _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "onShow":
        setState(() {
          isExposed = true;
        });
        widget.callback?.onShow?.call();
        break;
      case "onClick":
        widget.callback?.onClick?.call();
        break;
      case "onError":
        setState(() {
          isDismissed = true;
        });
        widget.callback?.onFail?.call();
        break;
      case "onDismiss":
        setState(() {
          isDismissed = true;
        });
        widget.callback?.onClose?.call();
        break;
    }
  }
}
