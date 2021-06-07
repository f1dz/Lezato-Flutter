import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'menu.g.dart';

@HiveType(typeId: 2)
class Menu {
  Menu({
    @required this.name,
  });

  @HiveField(0)
  String name;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
