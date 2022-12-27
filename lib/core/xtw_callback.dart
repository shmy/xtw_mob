import 'dart:ui';

class XTWCallback {
  final VoidCallback? onShow;
  final VoidCallback? onClick;
  final VoidCallback? onFail;
  final VoidCallback? onClose;
  final VoidCallback? onReward;
  final VoidCallback? onSkip;

  XTWCallback({
    this.onShow,
    this.onClick,
    this.onFail,
    this.onClose,
    this.onReward,
    this.onSkip,
  });
}
