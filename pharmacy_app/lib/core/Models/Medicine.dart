//import 'dart:ffi';

import 'Category.dart';
//import 'PharmacyMedicine.dart';

class Medicine {
  int? Id;
  String? Name;
  String? Description;
  String? ImageUrl;
  String? Company;
  String? MadeIn;
  double? Price;
  String? DateCreated;
  String? ExpirationDate;
  //List<PharmacyMedicine>? PharmacyMedicines;
  int? CategoryId;
  Category? category;

  Medicine({
    this.Id,
    this.Name,
    this.Description,
    this.ImageUrl,
    this.Company,
    this.MadeIn,
    this.Price,
    this.DateCreated,
    this.ExpirationDate,
    this.CategoryId,
    this.category,
    //this.PharmacyMedicines
  });

  factory Medicine.fromJson(Map<String,dynamic> json)
  {
    return Medicine(
      Id: json['id'] ?? 0,
      Name: json['name'] ?? '',
      Description: json['description'],
      ImageUrl: json['imageUrl'],
      Company: json['company'],
      MadeIn: json['madeIn'], 
      Price: json['price'],
      DateCreated: json['dateCreated'],
      ExpirationDate: json['expirationDate'],
      CategoryId: json['categoryId'],
      //category: Category.fromJson(json['category']),
    );
  } 
}