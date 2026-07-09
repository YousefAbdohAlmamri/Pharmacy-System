import 'dart:io';
import 'User.dart';
import 'dart:typed_data';
import 'dart:convert';


class CreatepharmacyDto {
  int? Id; 
  String? Name; 
  String? Description;
  String? Location;
  String? Phone;
  int? UserId;
  File? ImageFile;
  //public IFormFile ImageFile { get; set; }
  //public List<PharmacyMedicineDto> Medicines { get; set; }
  String? Medicines;
  // File? imageFile,
  // Uint8List imageBytes,

  CreatepharmacyDto({
    this.Id,
    this.Name,
    this.Description,
    this.Location,
    this.Phone,
    this.UserId,
    this.ImageFile,
    this.Medicines
  });

  factory CreatepharmacyDto.fromJson(Map<String,dynamic> json){
    //var medicineList = (json['pharmacyMedicines'] as List).map((e) => PharmacyMedicine.fromJson(e)).toList();
    return CreatepharmacyDto(
      //Id: json['id'] ?? 0,
      Name: json['name'] ?? '',
      Description: json['description'],
      Location: json['location'],
      Phone: json['phone'],
      UserId: json['userId'],
      ImageFile: json['imageFile'],
      Medicines: json['medicines']
      //pharmacyMedicines: PharmacyMedicine.fromJson(json['pharmacyMedicines']),
    );
  }
}