import 'package:flutter/material.dart';
import 'package:lezato/provider/app_provider.dart';
import 'package:lezato/ui/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Lezato',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
