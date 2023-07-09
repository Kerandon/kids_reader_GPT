import 'package:flutter/material.dart';

class BounceAnimation extends StatefulWidget {
  const BounceAnimation({required this.child, this.animate = true, this.endScale = 1.05, Key? key})
      : super(key: key);

  final Widget child;
  final bool animate;
  final double endScale;

  @override
  State<BounceAnimation> createState() => _BounceAnimationState();
}

class _BounceAnimationState extends State<BounceAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    _animation = Tween<double>(begin: 1.0, end: widget.endScale).animate(
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
  void didUpdateWidget(covariant BounceAnimation oldWidget) {
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
