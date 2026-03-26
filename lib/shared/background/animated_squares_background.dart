import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedSquaresBackground extends StatefulWidget {
  final Widget child;
  const AnimatedSquaresBackground({super.key, required this.child});

  @override
  State<AnimatedSquaresBackground> createState() => _AnimatedSquaresBackgroundState();
}

class _AnimatedSquaresBackgroundState extends State<AnimatedSquaresBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: _SquaresPainter(_controller.value),
          child: widget.child,
        );
      },
    );
  }
}

class _SquaresPainter extends CustomPainter {
  final double progress;
  _SquaresPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    for (var i = 0; i < 18; i++) {
      final dx = (random.nextDouble() * size.width + (progress * 80 * (i % 3))) % size.width;
      final dy = (random.nextDouble() * size.height + (progress * 60 * (i % 5))) % size.height;
      final squareSize = 20.0 + random.nextDouble() * 50;
      final paint = Paint()
        ..color = Colors.white.withOpacity(0.05 + random.nextDouble() * 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(dx, dy, squareSize, squareSize), const Radius.circular(8)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SquaresPainter oldDelegate) => oldDelegate.progress != progress;
}
