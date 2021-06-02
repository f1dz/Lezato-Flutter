import 'package:flutter/foundation.dart';

class Categories {
  Categories({@required this.name});

  String name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
