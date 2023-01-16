import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switch_theme/app_theme.dart';

class Wire extends StatefulWidget {
  const Wire({Key? key, required this.initialPosition, required this.toOffset})
      : super(key: key);
  final Offset initialPosition;
  final Offset toOffset;

  @override
  State<Wire> createState() => _WireState();
}

class _WireState extends State<Wire> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return CustomPaint(
      painter: WirePainter(
        initialPosition: widget.initialPosition,
        toOffset: widget.toOffset,
        themeProvider: themeProvider,
      ),
    );
  }
}

class WirePainter extends CustomPainter {
  final Offset initialPosition;
  final Offset toOffset;
  final ThemeProvider themeProvider;

  Paint? _paint;

  WirePainter(
      {required this.initialPosition,
      required this.toOffset,
      required this.themeProvider});

  @override
  void paint(Canvas canvas, Size size) {
    _paint = Paint()
      ..color = themeProvider.themeMode().switchColor!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawLine(initialPosition, toOffset, _paint!);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
