import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'categories.g.dart';

@HiveType(typeId: 3)
class Categories {
  Categories({@required this.name});

  @HiveField(0)
  String name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
