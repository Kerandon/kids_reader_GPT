import 'package:flutter/material.dart';

class Bounce extends StatefulWidget {
  const Bounce({required this.child, this.animate = true, Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;

  @override
  State<Bounce> createState() => _BounceState();
}

class _BounceState extends State<Bounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.animate) {
      _startAnimation();
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Bounce oldWidget) {
    if (widget.animate) {
      _startAnimation();
    } else {
      _stopAnimation();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() {
    if (!_animationController.isAnimating) {
      _animationController.repeat(reverse: true);
    }
  }

  void _stopAnimation() {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
