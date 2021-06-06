import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezato/data/model/categories.dart';
import 'package:lezato/data/model/menu.dart';
import 'package:lezato/data/model/menus.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/ui/splash_screen.dart';
import 'package:lezato/utils/config.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(MenusAdapter());
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ReviewAdapter());
  await Hive.openBox(Config.BOX_FAVORITES);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lezato',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashScreen(),
    );
  }
}
