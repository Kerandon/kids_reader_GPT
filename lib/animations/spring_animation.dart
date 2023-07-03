import 'package:flutter/material.dart';

class SpringAnimation extends StatefulWidget {
  const SpringAnimation(
      {required this.child,
      required this.animate,
      required this.startOffset,
      required this.endOffset,
      Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;
  final Offset startOffset, endOffset;

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
        duration: const Duration(milliseconds: 2000), vsync: this);

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
