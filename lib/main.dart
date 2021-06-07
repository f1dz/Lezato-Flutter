import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lezato/data/common/navigation.dart';
import 'package:lezato/data/model/categories.dart';
import 'package:lezato/data/model/menu.dart';
import 'package:lezato/data/model/menus.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/ui/detail_screen.dart';
import 'package:lezato/ui/home_screen.dart';
import 'package:lezato/ui/splash_screen.dart';
import 'package:lezato/utils/background_service.dart';
import 'package:lezato/utils/config.dart';
import 'package:lezato/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) await AndroidAlarmManager.initialize();

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantAdapter());
  Hive.registerAdapter(MenusAdapter());
  Hive.registerAdapter(MenuAdapter());
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(ReviewAdapter());
  await Hive.openBox(Config.BOX_FAVORITES);
  await Hive.openBox(Config.BOX_DARK_MODE);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(Config.BOX_DARK_MODE).listenable(),
      builder: (BuildContext context, box, Widget child) {
        var darkMode = box.get('darkMode', defaultValue: false);
        return MaterialApp(
            title: 'Lezato',
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            darkTheme: ThemeData.dark(),
            home: SplashScreen(),
            navigatorKey: navigatorKey,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              DetailScreen.routeName: (context) =>
                  DetailScreen(restaurant: ModalRoute.of(context).settings.arguments as Restaurant),
            });
      },
    );
  }
}
