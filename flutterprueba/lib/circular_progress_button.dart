import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressButton extends StatefulWidget {
  final double size;
  final Duration duration;

  const CircularProgressButton({
    Key? key,
    this.size = 120.0,
    this.duration = const Duration(seconds: 4),
  }) : super(key: key);

  @override
  _CircularProgressButtonState createState() => _CircularProgressButtonState();
}

class _CircularProgressButtonState extends State<CircularProgressButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final value = _controller.value; // 0.0 - 1.0
                final percent = (value * 100).round();
                return CustomPaint(
                  painter: _CircleProgressPainter(progress: value),
                  child: Center(
                    child: Text(
                      '$percent%',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _startAnimation,
            child: const Text('Iniciar Animación'),
          ),
        ],
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress; // 0.0 - 1.0

  _CircleProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 12.0;
    final center = size.center(Offset.zero);
    final radius = (size.width / 2) - strokeWidth / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Determinar el color según el progreso con transición fluida
    Color progressColor;
    if (progress < 0.2) {
      // 0-20%: rojo
      progressColor = Colors.red;
    } else if (progress < 0.7) {
      // 20-70%: transición de amarillo a naranja
      final t = (progress - 0.2) / 0.5; // normalizar 0.2-0.7 a 0.0-1.0
      progressColor = Color.lerp(Colors.orange, Colors.yellow, t)!;
    } else {
      // 70-100%: transición de amarillo a verde
      final t = (progress - 0.7) / 0.3; // normalizar 0.7-1.0 a 0.0-1.0
      progressColor = Color.lerp(Colors.yellow, Colors.green, t)!;
    }

    final foregroundPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // fondo
    canvas.drawCircle(center, radius, backgroundPaint);

    // progreso (0 a 2π)
    final sweep = progress * 2 * math.pi;
    final startAngle = -math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
