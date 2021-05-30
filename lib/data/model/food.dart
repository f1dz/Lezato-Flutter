import 'package:flutter/material.dart';

class Food {
  Food({
    @required this.name,
  });

  String name;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
