class Pharmacysmedicines {

    int? Id;
    String? Name;
    String? Description;
    String? Company;
    String? MadeIn;
    double? Price;
    String? DateCreated;
    String? ExpirationDate;
    String? ImageName;
    int? Stock;
    String? CategoryName;


  Pharmacysmedicines({
    this.Id,
    this.Name,
    this.Description,
    this.Company,
    this.MadeIn,
    this.Price,
    this.DateCreated,
    this.ExpirationDate,
    this.ImageName,
    this.Stock,
    this.CategoryName
  });

  factory Pharmacysmedicines.fromJson(Map<String,dynamic> json)
  {
    return Pharmacysmedicines(
      Id: json['id'] ?? 0,
      Name: json['name'] ?? '',
      Description: json['description'],
      ImageName: json['imageName'],
      Company: json['company'],
      MadeIn: json['madeIn'], 
      Price: json['price'],
      DateCreated: json['dateCreated'],
      ExpirationDate: json['expirationDate'],
      CategoryName: json['categoryName'],
      Stock: json['stock'],
      //category: Category.fromJson(json['category']),
    );
  }
}