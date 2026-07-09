class User {
  int? Id;
  String? Name;
  String? Password;
  String? Phone;


  User({
    this.Id,
    this.Name,
    this.Password,
    this.Phone,
  });

  factory User.fromJson(Map<String,dynamic> json)
  {
    return User(
      Id: json['id'],
      Name: json['name'],
      Password: json['password'],
      Phone: json['phone'],
    );
  }
}