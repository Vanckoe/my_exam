class AppUser {
  final String name;
  final String email;
  final String age;
  final String country;
  final String gender;
  final String phone;

  AppUser({
    required this.name,
    required this.email,
    required this.age,
    required this.country,
    required this.gender,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'country': country,
      'gender': gender,
      'phone': phone,
    };
  }

    static AppUser fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
      country: map['country'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
    );
  }
}
