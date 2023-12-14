import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_market/generated/locale_keys.g.dart';


class Anime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: AdvancedFinanceAnimationPage(),
    );
  }
}

class AdvancedFinanceAnimationPage extends StatefulWidget {
  @override
  _AdvancedFinanceAnimationPageState createState() => _AdvancedFinanceAnimationPageState();
}

class _AdvancedFinanceAnimationPageState extends State<AdvancedFinanceAnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  List<double> dataPoints = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        dataPoints.add(Random().nextDouble() * 100);
        if (dataPoints.length > 10) dataPoints.removeAt(0);
        controller.forward(from: 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.Prof_fin.tr()),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: FinanceChartPainter(dataPoints, controller.value, Theme.of(context).brightness),
            child: Container(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class FinanceChartPainter extends CustomPainter {
  List<double> dataPoints;
  double animationValue;
  Brightness brightness;

  FinanceChartPainter(this.dataPoints, this.animationValue, this.brightness);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = (brightness == Brightness.dark) ? Colors.white : Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();

    for (int i = 0; i < dataPoints.length; i++) {
      if (i == 0) {
        path.moveTo(i * size.width / 10, size.height - dataPoints[i] * animationValue);
      } else {
        path.lineTo(i * size.width / 10, size.height - dataPoints[i] * animationValue);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FinanceChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints || oldDelegate.animationValue != animationValue;
  }
}