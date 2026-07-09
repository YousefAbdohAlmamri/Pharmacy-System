import 'User.dart';

class Pharmacy {
  int Id; 
  String Name; 
  String? Description;
  String? Location;
  String? Phone;
  int? UserId;
  User? user;
  String? ImageUrl;
  //public IFormFile ImageFile { get; set; }
  //public List<PharmacyMedicineDto> Medicines { get; set; }
  List<dynamic>? pharmacyMedicines;
   //PharmacyMedicine? pharmacyMedicines;
  bool isFavorite = false;

  Pharmacy({
    required this.Id,
    required this.Name,
    this.Description,
    this.Location,
    this.Phone,
    this.UserId,
    this.user,
    this.ImageUrl,
    this.pharmacyMedicines
  });

  factory Pharmacy.fromJson(Map<String,dynamic> json){
    //var medicineList = (json['pharmacyMedicines'] as List).map((e) => PharmacyMedicine.fromJson(e)).toList();
    return Pharmacy(
      Id: json['id'] ?? 0,
      Name: json['name'] ?? '',
      Description: json['description'],
      Location: json['location'],
      Phone: json['phone'],
      UserId: json['userId'],
      user: User.fromJson(json['user']),
      ImageUrl: json['imageUrl'],
      //pharmacyMedicines: PharmacyMedicine.fromJson(json['pharmacyMedicines']),
    );
  }
}