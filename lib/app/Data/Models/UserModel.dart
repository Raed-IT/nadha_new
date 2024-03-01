import 'package:delevary/app/Data/Enums/GenderTypeEnum.dart';
import 'package:delevary/app/Data/Enums/MaritalStatusEnum.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';

class UserModel {
  int? id;
  String? name;
  MaritalStatusEnum? martialStatus;
  GenderTypeEnum? gender;
  String? email;
  String? bio;
  String? phone;
  int? age;
  CityModel? city;

  UserModel(this.id, this.name, this.martialStatus, this.gender, this.email,
      this.bio, this.phone, this.age);

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    age = json['age'];
    if (json['city']!=null){
    city = CityModel.fromJson(json['city']);
    }
  }
}
