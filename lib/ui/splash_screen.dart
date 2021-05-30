import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lezato/ui/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    openHome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
                child: Center(
                    child: Container(
      padding: const EdgeInsets.all(0.0),
      width: 300,
      height: 300,
      child: Lottie.asset("assets/json/resto.json"),
    )))));
  }

  openHome() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }));
    });
  }
}
