class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
    };
  }
}
