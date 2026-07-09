import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pharmacy_app/core/Models/PharmacyDetails.dart';
import 'package:pharmacy_app/core/Models/pharmacysMedicines.dart';

void main() async{
    try {
    final response = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies/search/Panadol_Extra'));

    if (response.statusCode == 200)
    {
      // print(response.body);
      final  List<dynamic> jsonResponse = json.decode(response.body);
      var data = jsonResponse.map((e) => PharmacyDetails.fromJson(e)).toList();
      for (var i in data)
      {
        print(i.Id);
        print(i.Name);
        print(i.Description);
        print(i.Location);
        print(i.Phone);
        print(i.ImageUrl);


      }
      // return jsonResponse.map((get) => Pharmacysmedicines.fromJson(get)).toList();
    } else {
      throw Exception('فشل تحميل الصيدليات');
    }
  }
  catch(e) {
    print("Error ${e}");
  }
}