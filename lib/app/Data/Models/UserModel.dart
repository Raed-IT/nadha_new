import 'package:delevary/app/Data/Enums/GenderTypeEnum.dart';
import 'package:delevary/app/Data/Enums/MaritalStatusEnum.dart';
import 'package:delevary/app/Data/Models/AddressModel.dart';
import 'package:delevary/app/Data/Models/CityModel.dart';
import 'package:delevary/app/Data/Models/StoreModel.dart';

class UserModel {
  bool? isDelivery;
  int? id;
  String? name;
  String? image;
  MaritalStatusEnum? martialStatus;
  GenderTypeEnum? gender;
  String? email;
  String? bio;
  String? phone;
  int? age;
  CityModel? city;
  List<AddressModel>? addresses;
  StoreModel? store;
  double? balance;

  UserModel(this.id, this.image, this.name, this.martialStatus, this.gender,
      this.email, this.bio, this.phone, this.age);

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = double.tryParse('${json['store_balance']}');
    name = json['name'];
    isDelivery = json['is_delivery'];
    if (json.containsKey("addresses")) {
      addresses = [];
      for (var address in json['addresses']) {
        addresses!.add(AddressModel.fromJson(address));
      }
    }
    if (json.containsKey("store") && json['store'] != null) {
      store = StoreModel.fromJson(json['store']);
    }
    image = json['image'];
    email = json['email'];
    bio = json['bio'];
    phone = json['phone'];
    age = json['age'];
    if (json['city'] != null) {
      city = CityModel.fromJson(json['city']);
    }
  }
}
