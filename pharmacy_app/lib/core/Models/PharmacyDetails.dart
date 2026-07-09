class PharmacyDetails {
  int? Id;
  String? Name;
  String? Description;
  String? Location;
  String? Phone;
  String? ImageUrl;

  PharmacyDetails({
    this.Id,
    this.Name,
    this.Description,
    this.Location,
    this.Phone,
    this.ImageUrl
  });

  factory PharmacyDetails.fromJson(Map<String,dynamic> json)
  {
    return PharmacyDetails(
      Id: json['id'],
      Name: json['name'],
      Description: json['description'],
      Location: json['location'],
      Phone: json['phone'],
      ImageUrl: json['imageUrl']
    );
  }
}