import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lezato/data/model/response/response_restaurant.dart';
import 'package:lezato/data/model/response/response_restaurant_detail.dart';
import 'package:lezato/data/model/response/response_review.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/utils/config.dart';
import 'package:lezato/utils/const_string.dart';

class ApiService {
  Future<ResponseRestaurant> getList() async {
    try {
      final response = await http.get(Uri.parse(Config.BASE_URL + 'list'));
      if (response.statusCode == 200) {
        return ResponseRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(ConstString.failed_get_data);
      }
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<ResponseRestaurant> search({String query = ""}) async {
    try {
      final response = await http.get(Uri.parse(Config.BASE_URL + 'search?q=' + query));
      if (response.statusCode == 200) {
        return ResponseRestaurant.fromJson(json.decode(response.body));
      } else {
        throw Exception(ConstString.failed_get_data);
      }
    } catch (e) {
      throw Exception(e.message);
    }
  }

  Future<ResponseRestaurantDetail> getDetail(String id) async {
    final response = await http.get(Uri.parse(Config.BASE_URL + 'detail/$id'));
    if (response.statusCode == 200) {
      return ResponseRestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(ConstString.failed_get_data);
    }
  }

  Future<ResponseReview> postReview(Review review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(Config.BASE_URL + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ResponseReview.fromJson(json.decode(response.body));
    } else {
      throw Exception(ConstString.failed_post_review);
    }
  }
}
