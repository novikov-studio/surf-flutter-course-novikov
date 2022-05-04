import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Скопирована реализация [CircularProgressIndicator], вариант MaterialIndicator.
///
///  - Однотонный цвет заменен на градиент.
///  - Закруглены края на концах дуги.
class GradientProgressIndicator extends StatefulWidget {
  final List<Color> colors;
  final List<double>? stops;
  final double? value;
  final Color? backgroundColor;
  final double strokeWidth;

  const GradientProgressIndicator({
    Key? key,
    required this.colors,
    this.stops,
    this.value,
    this.backgroundColor,
    this.strokeWidth = 2.0,
  }) : super(key: key);

  @override
  State<GradientProgressIndicator> createState() =>
      _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<GradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _offsetTween =
      CurveTween(curve: const SawTooth(_pathCount));
  static final Animatable<double> _rotationTween =
      CurveTween(curve: const SawTooth(_rotationCount));

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );
    if (widget.value == null) _controller.repeat();
  }

  @override
  void didUpdateWidget(GradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
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
      builder: (context, child) {
        return _buildMaterialIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  // ignore: long-parameter-list
  Widget _buildMaterialIndicator(
    BuildContext context,
    double headValue,
    double tailValue,
    double offsetValue,
    double rotationValue,
  ) {
    final trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: _kMinCircularProgressIndicatorSize,
        minHeight: _kMinCircularProgressIndicatorSize,
      ),
      child: CustomPaint(
        painter: _GradientProgressIndicatorPainter(
          backgroundColor: trackColor,
          colors: widget.colors,
          stops: widget.stops,
          value: widget.value,
          // may be null
          headValue: headValue,
          // remaining arguments are ignored if widget.value is not null
          tailValue: tailValue,
          offsetValue: offsetValue,
          rotationValue: rotationValue,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _GradientProgressIndicatorPainter extends CustomPainter {
  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = 0.001;

  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  final Color? backgroundColor;
  final List<Color> colors;
  final List<double>? stops;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  _GradientProgressIndicatorPainter({
    this.backgroundColor,
    required this.colors,
    this.stops,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 2.0 +
                offsetValue * 0.5 * math.pi,
        arcSweep = value != null
            ? value.clamp(0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon,
              );

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != null) {
      final backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(Offset.zero & size, 0, _sweep, false, backgroundPaint);
    }

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    if (value == null) {
      paint.strokeCap = StrokeCap.round;
    }

    final centerPoint = size.height / 2;

    paint.shader = SweepGradient(
      colors: colors,
      tileMode: TileMode.decal,
      stops: stops,
      transform:
          GradientRotation(value != null ? -math.pi / 2 : arcStart - 0.17),
    ).createShader(
      Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0),
    );

    canvas.drawArc(Offset.zero & size, arcStart, arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_GradientProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        // По идее, для colors и stops надо DeepEquals, но по факту
        // это просто лишняя нагрузка, т.к. крутится бесконечная анимация
        oldPainter.colors != colors ||
        oldPainter.stops != stops ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.offsetValue != offsetValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}

const int _kIndeterminateCircularDuration = 1333 * 2222;
const double _kMinCircularProgressIndicatorSize = 36.0;
