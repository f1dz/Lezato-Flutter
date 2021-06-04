import 'package:flutter/material.dart';

class Menu {
  Menu({
    @required this.name,
  });

  String name;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
