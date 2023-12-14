import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacementNamed(context, '/loginPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset('assets/lottie/finance.json'),
              SizedBox(height: 20),
              Text(
                'Araba',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[Colors.yellow, Colors.red],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
