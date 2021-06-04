import 'package:flutter/material.dart';

import 'menu.dart';

enum MenuType { food, drink }

class Menus {
  Menus({
    @required this.foods,
    @required this.drinks,
  });

  List<Menu> foods;
  List<Menu> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Menu>.from(json["foods"].map((x) => Menu.fromJson(x))),
        drinks: List<Menu>.from(json["drinks"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
