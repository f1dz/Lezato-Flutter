import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lezato/data/model/response/response_restaurant.dart';
import 'package:lezato/data/model/response/response_restaurant_detail.dart';

import '../utils/config.dart';

class ApiService {
  static Future<ResponseRestaurant> getList() async {
    final response = await http.get(Uri.parse(Config.BASE_URL + 'list'));
    if (response.statusCode == 200) {
      return ResponseRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurants');
    }
  }

  static Future<ResponseRestaurantDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse(Config.BASE_URL + 'detail/$id'));
    if (response.statusCode == 200) {
      return ResponseRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get detail restaurant');
    }
  }
}
