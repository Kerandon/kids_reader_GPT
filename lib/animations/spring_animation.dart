import 'package:flutter/material.dart';

import '../configs/constants.dart';

class SpringAnimation extends StatefulWidget {
  const SpringAnimation(
      {required this.child,
      required this.animate,
      this.reset = false,
      required this.startOffset,
      required this.endOffset,
      this.onComplete,
      Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;
  final bool reset;
  final Offset startOffset, endOffset;
  final Function? onComplete;

  @override
  State<SpringAnimation> createState() => _SpringAnimationState();
}

class _SpringAnimationState extends State<SpringAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: kSpringAnimationDuration),
        vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SpringAnimation oldWidget) {
    if (widget.animate) {
      _controller.forward();
    }
    if (widget.reset && !_controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween<Offset>(begin: widget.startOffset, end: widget.endOffset).animate(
            CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // print(
    //     'values  received is start ${widget.startOffset} and end ${widget.endOffset}');

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
          transform: Matrix4.identity()
            ..translate(animation.value.dx, animation.value.dy),
          child: widget.child),
    );
  }
}
