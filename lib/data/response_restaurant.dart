import 'package:lezato/data/model/restaurant.dart';

class ResponseRestaurant {
  ResponseRestaurant({this.restaurants});

  List<Restaurant> restaurants;

  factory ResponseRestaurant.fromJson(Map<String, dynamic> json) => ResponseRestaurant(
      restaurants: List<Restaurant>.from(json['restaurants'].map((x) => Restaurant.fromJson(x))));
}
