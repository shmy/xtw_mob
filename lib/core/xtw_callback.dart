import 'dart:ui';

class XTWCallback {
  final VoidCallback? onShow;
  final VoidCallback? onClick;
  final VoidCallback? onFail;
  final VoidCallback? onClose;
  final VoidCallback? onReward;

  XTWCallback({
    this.onShow,
    this.onClick,
    this.onFail,
    this.onClose,
    this.onReward,
  });
}
