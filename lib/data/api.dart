import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lezato/data/response_restaurant.dart';

class Api {
  static const String PATH = 'assets/json/local_restaurants.json';

  static Future<ResponseRestaurant> getData() async {
    return ResponseRestaurant.fromJson(await rootBundle.loadString(PATH).then((value) => jsonDecode(value)));
  }
}
