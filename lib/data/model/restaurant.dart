import 'package:flutter/foundation.dart';
import 'package:lezato/data/model/categories.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/data/utils/config.dart';

import 'menu.dart';

class Restaurant {
  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating,
      this.categories,
      this.menus,
      this.customerReviews});

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  List<Categories> categories;
  List<Menu> menus;
  List<Review> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: Config.IMG_SMALL_URL + json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      categories: json["categories"] == null
          ? null
          : List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
      menus: json["menus"] == null ? null : List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      customerReviews: json["customerReviews"] == null
          ? null
          : List<Review>.from(json["customerReviews"].map((x) => Review.fromJson(x))));
}
