class UserModel {
  String userId;
  String name;
  String lastName;
  String email;
  String phoneNumber;
  String address;

  UserModel({
    this.userId,
    this.name,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
