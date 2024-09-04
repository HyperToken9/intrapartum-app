import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final double size;
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Color borderColor;

  const ProgressBar({
    super.key,
    this.size = 300,
    this.progress = 30,
    this.color = const Color(0xFF8D77FB),
    this.backgroundColor = const Color(0xFFF7E7EF),
    this.strokeWidth = 22,
    this.borderColor = Colors.black,
  });

  @override
  _ArcProgressBarState createState() => _ArcProgressBarState();
}

class _ArcProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _restartAnimation() {
    _animation = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward(from: 0);
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _restartAnimation();
    }
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: ArcProgressBarPainter(
            progress: _animation.value,
            color: widget.color,
            backgroundColor: widget.backgroundColor,
            strokeWidth: widget.strokeWidth,
            borderColor: widget.borderColor,
          ),
        );
      },
    );
  }
}

class ArcProgressBarPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final double borderWidth = 3;
  final Color borderColor;
  final double sweepRatio = 0.6;

  ArcProgressBarPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {

    Paint borderPaint = Paint()
      ..color = borderColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + borderWidth ;

    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;



    double radius = (size.width / 2) - (strokeWidth / 2);
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = pi / 2 + (2 * pi - 2 * pi * sweepRatio) / 2;
    double sweepAngle = 2 * pi * sweepRatio * (progress / 100);


    // Draw border arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi * sweepRatio,
      false,
      borderPaint,
    );

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi * sweepRatio,
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
