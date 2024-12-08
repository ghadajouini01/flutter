import 'package:clone_jumia/utils/json_utils.dart';

class User {
  String? id;
  String? email;
  String? password;
  String? phoneNbr;
  String? fcm;

  User({this.id, this.email, this.password, this.phoneNbr, this.fcm});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: JsonUtils.attribute(json['email']),
      password: JsonUtils.attribute(json['password']),
      phoneNbr: JsonUtils.attribute(json['phoneNbr']),
      fcm: JsonUtils.attribute(json['fcm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "password": password,
      "phoneNbr": phoneNbr,
      "fcm": fcm,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
