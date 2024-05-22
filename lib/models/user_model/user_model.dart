import 'dart:convert';

UserModel userModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String name;
  String? image;
  String email;

  UserModel({
    required this.id,
    this.image,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
    UserModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      email: json['email'],
    );


  Map<String, dynamic> toJson() => {
      "id": id,
      "image": image,
      "name": name,
      "email": email,
    };

  UserModel copyWith({
    String? name,image,

  }) => UserModel(
    id: id,
    name: name?? this.name,
    email: email,
    image: image?? this.image,
  );
}
