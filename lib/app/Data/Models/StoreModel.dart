import 'package:delevary/app/Data/Models/CityModel.dart';

class StoreModel {
  int? id;
  String? name;
  String? address;
  String? info;
  double? lat;
  double? long;
  CityModel? city;

  StoreModel(this.id, this.name, this.address, this.info, this.lat, this.long,
      this.city);

  StoreModel.fronJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    info = json['info'];
    lat = json['lat'];
    long = json['long'];
    city = CityModel.fromJson(json['city']);
  }
}
