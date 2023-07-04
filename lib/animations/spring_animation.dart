import 'package:flutter/material.dart';

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

  // final spring = const SpringDescription(
  //   mass: 10,
  //   stiffness: 1,
  //   damping: 1,
  // );
  // late final _simulation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onComplete?.call();
        }
      });

    // _simulation = SpringSimulation(spring, 0, 1, 1);
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
    final animation = Tween<Offset>(
            begin: widget.startOffset, end: widget.endOffset)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

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
