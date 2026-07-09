import 'dart:convert';
import 'dart:io';
//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pharmacy_app/core/Models/Category.dart';
import 'package:pharmacy_app/core/Models/CreatePharmacyDto.dart';
import 'package:pharmacy_app/core/Models/Medicine.dart';
import 'package:pharmacy_app/core/Models/PharmacyDetails.dart';
//import 'package:pharmacy_app/core/Models/User.dart';
import 'package:pharmacy_app/core/Models/pharmacysMedicines.dart';
import '../core/Models/Pharmacy.dart';

class ApiService {
  Future<List<Pharmacy>> getPharmacies() async {
    final response = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies'));

    if (response.statusCode == 200)
    {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((get) => Pharmacy.fromJson(get)).toList();
    } else {
      throw Exception('فشل تحميل الصيدليات');
    }
  }

  Future<Medicine> getMedicineById(int id) async {
    final pharmacy = await http.get(Uri.parse('https://localhost:44383/api/Medicines/$id'));
    if (pharmacy.statusCode == 200)
    {
      return Medicine.fromJson(json.decode(pharmacy.body));
    } else {
      throw Exception('فشل تحميل الدواء');
    }
  }
  
  Future<List<Pharmacysmedicines>> getPharmacysMedicines(int pharmacyId) async {
    final response = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies/PharmacysMedicines/${pharmacyId}'));

    if (response.statusCode == 200)
    {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((get) => Pharmacysmedicines.fromJson(get)).toList();
    } else {
      throw Exception('فشل تحميل الأدوية');
    }
  }
  
  Future<List<PharmacyDetails>> SearchPharmacyByMedicine(String name) async {
    
  
    final response = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies/search/${name}'));

    if (response.statusCode == 200)
    {
      // print(response.body);
      final  List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => PharmacyDetails.fromJson(e)).toList();
      
      
      // return jsonResponse.map((get) => Pharmacysmedicines.fromJson(get)).toList();
    } else {
      throw Exception('فشل تحميل الصيدليات');
    }
  
  
  }
  
  Future<Object> getData(int id) async {
    // final pharmacy = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies/$id'));
    // if (pharmacy.statusCode == 200)
    // {
    //   return Pharmacy.fromJson(json.decode(pharmacy.body));
    // } else {
    //   throw Exception('فشل تحميل الصيدليات');
    // }
        
    final pharmacy = getPharmacy(id);
    final medicine = getMedicine();
    final category = getCategory();

    var entitys = [pharmacy,medicine,category];

    return entitys;
    
  }


  Future<Pharmacy> getPharmacy(int id) async {
    final pharmacy = await http.get(Uri.parse('https://localhost:44383/api/Pharmacies/$id'));
    if (pharmacy.statusCode == 200)
    {
      return Pharmacy.fromJson(json.decode(pharmacy.body));
    } else {
      throw Exception('فشل تحميل الصيدليات');
    }
  }
  
   static Future<List<Map<String,dynamic>>> getMedicine() async {
    final medicine = await http.get(Uri.parse('https://localhost:44383/api/Medicines'));
    if (medicine.statusCode == 200)
    {
      List jsonResponse = json.decode(medicine.body);
      return jsonResponse.cast<Map<String,dynamic>>();
    } else {
      throw Exception('فشل تحميل الادوية');
    }
  }
  

  static Future<List<Map<String,dynamic>>> getUsers() async {
    final users = await http.get(Uri.parse('https://localhost:44383/api/Users'));
    if (users.statusCode == 200)
    {
      List jsonResponse = json.decode(users.body);
      return jsonResponse.cast<Map<String,dynamic>>();
    } else {
      throw Exception('فشل تحميل الادوية');
    }
  }

  Future<List<Category>> getCategory() async {
    final category = await http.get(Uri.parse('https://localhost:44383/api/Categories'));
    if (category.statusCode == 200)
    {
      List jsonResponse = json.decode(category.body);
      return jsonResponse.map((get) => Category.fromJson(get)).toList();
    } else {
      throw Exception('فشل تحميل الفئات');
    }
  }


  static Future<bool> addPharmacy(
    CreatepharmacyDto createPharmacyDto
    ) async {
      var uri = Uri.parse('https://localhost:44383/api/Pharmacies');
      var request = http.MultipartRequest("POST", uri);

      request.fields['Name'] = createPharmacyDto.Name!;
      request.fields['Description'] = createPharmacyDto.Description!;
      request.fields['Location'] = createPharmacyDto.Location!;
      request.fields['Phone'] = createPharmacyDto.Phone!;
      request.fields['UserId'] = createPharmacyDto.UserId.toString();
      request.fields['Medicines'] = jsonEncode(createPharmacyDto.Medicines);
      request.files.add(await http.MultipartFile.fromPath('ImageFile',createPharmacyDto.ImageFile!.path));
      //request.files.add(await http.MultipartFile.fromBytes('ImageFile',imageBytes as List<int>,filename:imageFileName));

      var response = await request.send();

      if (response.statusCode == 201) {
        print("Pharmacy added successfuly");
        var result = await http.Response.fromStream(response);
        print("Response: ${result.body}");
        return true;
      }else {
        print("Faild: ${response.statusCode}");
        var result = await http.Response.fromStream(response);
        print("Error body: ${result.body}");
        return false;
      }
  }

}


// {
//     // required String name,
//     // required String description,
//     // required String location,
//     // required String phone,
//     // required int userId,
//     // required File? imageFile,
//     // required Uint8List? imageBytes,
//     // String? imageFileName,
//     // required String medicines,
//     //required List<Map<String, dynamic>> medicines,
//     }