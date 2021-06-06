import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:lezato/data/model/categories.dart';
import 'package:lezato/data/model/review.dart';
import 'package:lezato/utils/config.dart';

import 'menus.dart';

part 'restaurant.g.dart';

@HiveType(typeId: 0)
class Restaurant {
  Restaurant(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.pictureId,
      @required this.city,
      @required this.rating,
      this.address,
      this.categories,
      this.menus,
      this.customerReviews});

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String pictureId;
  @HiveField(4)
  String address;
  @HiveField(5)
  String city;
  @HiveField(6)
  double rating;
  @HiveField(7)
  List<Categories> categories;
  @HiveField(8)
  Menus menus;
  @HiveField(9)
  List<Review> customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      address: json["address"] == null ? null : json["address"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      categories: json["categories"] == null
          ? null
          : List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
      menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
      customerReviews: json["customerReviews"] == null
          ? null
          : List<Review>.from((json["customerReviews"] as List)
              .map((x) => Review.fromJson(x))
              .where((review) => review.review != null && review.name.length > 0)));

  String getSmallPicture() => Config.IMG_SMALL_URL + this.pictureId;

  String getMediumPicture() => Config.IMG_MEDIUM_URL + this.pictureId;

  String getLargePicture() => Config.IMG_LARGE_URL + this.pictureId;
}
