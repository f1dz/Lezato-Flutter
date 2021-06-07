import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lezato/data/common/navigation.dart';
import 'package:lezato/data/model/response/response_restaurant.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/ui/detail_screen.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
        var data = Restaurant.fromJson(json.decode(payload));
        await Navigation.intentWithData(DetailScreen.routeName, data);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, ResponseRestaurant restaurants) async {
    var restaurant = restaurants.restaurants[Random().nextInt(restaurants.restaurants.length)];
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Lezato info";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Lezato Info</b>";
    var titleNews = "New promo ${Random().nextInt(90)}% off at " + restaurant.name;

    await flutterLocalNotificationsPlugin.show(0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurant.fromJson(json.decode(payload));
        Navigation.intentWithData(route, data);
      },
    );
  }
}
