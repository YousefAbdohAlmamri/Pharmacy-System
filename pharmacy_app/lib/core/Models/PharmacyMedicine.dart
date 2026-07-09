import 'Medicine.dart';
//import 'Pharmacy.dart';

class PharmacyMedicine {
  //int? PharmacyId;
  //Pharmacy? pharmacy;
  int? MedicineId;
  Medicine? medicine;
  int? Stock;

  PharmacyMedicine({
    //this.PharmacyId,
    //this.pharmacy,
    this.MedicineId,
    this.medicine,
    this.Stock
  });

  factory PharmacyMedicine.fromJson(Map<String,dynamic> json) {
    return PharmacyMedicine(
      //PharmacyId: json['pharmacyId'],
      //pharmacy: Pharmacy.fromJson(json['pharmacy']),
      MedicineId: json['medicineId'],
      medicine: Medicine.fromJson(json['medicine']),
      Stock: json['stock'],
    );
  }
}