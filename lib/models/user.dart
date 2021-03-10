import 'package:directus/directus.dart';

class User extends DirectusUser {
  String phone;
  String userCode;
  User({email, password, this.phone, this.userCode})
      : super(email: email, password: password);

  factory User.fromJson(Map<String, dynamic> json) => User(
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        userCode: json["user_code"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "password": password,
        "user_code": userCode,
      };
}
