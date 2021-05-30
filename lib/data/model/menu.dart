import 'package:flutter/material.dart';

import 'drink.dart';
import 'food.dart';

class Menu {
  Menu({
    @required this.foods,
    @required this.drinks,
  });

  List<Food> foods;
  List<Drink> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
