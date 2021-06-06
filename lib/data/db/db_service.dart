import 'dart:async';

import 'package:hive/hive.dart';
import 'package:lezato/data/model/restaurant.dart';
import 'package:lezato/utils/config.dart';

class DbService {
  Box<dynamic> box;

  DbService() {
    box = Hive.box(Config.BOX_FAVORITES);
  }

  Future<List<Restaurant>> getFavorites() async {
    return box.values.toList().cast<Restaurant>();
  }

  Future<List<Restaurant>> toggleFavorite(Restaurant restaurant) async {
    try {
      if (box.get(restaurant.id) == null)
        box.put(restaurant.id, restaurant);
      else
        box.delete(restaurant.id);

      return box.values.toList().cast<Restaurant>();
    } catch (e) {
      throw HiveError(e.toString());
    }
  }
}
