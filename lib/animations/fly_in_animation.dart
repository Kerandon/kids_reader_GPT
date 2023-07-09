import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FlyInAnimation extends StatefulWidget {
  const FlyInAnimation(
      {required this.child,
      required this.animate,
        this.reset = false,
      this.animateOnStart = true,
      Key? key})
      : super(key: key);

  final Widget child;
  final bool animate, reset;
  final bool animateOnStart;

  @override
  State<FlyInAnimation> createState() => _FlyInAnimationState();
}

class _FlyInAnimationState extends State<FlyInAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1200), vsync: this);

    _scaleAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _rotateAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
    if (widget.animateOnStart) {
      _controller.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlyInAnimation oldWidget) {
    if (widget.animate) {
      _controller.forward();
    }
    if(widget.reset){
      _controller.reset();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.005)
          ..scale(_scaleAnimation.value)
          ..rotateX(_rotateAnimation.value * pi)
          ..rotateY(_rotateAnimation.value * pi)
          ..rotateZ(_rotateAnimation.value * pi),
        child: widget.child,
      ),
    );
  }
}
