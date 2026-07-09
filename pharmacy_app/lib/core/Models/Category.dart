//import 'package:flutter/foundation.dart';

class Category {
  int? Id;
  String? Name;

  Category({
    this.Id,
    this.Name
  });

  factory Category.fromJson(Map<String,dynamic> json)
  {
    return Category(
      Id: json['id'] ?? 0,
      Name: json['name'] ?? '',
    );
  } 
}