import 'package:delevary/app/Data/Models/CityModel.dart';

class StoreModel {
  int? id;
  String? name;
  String? uniqName;
  String? address;
  String? image;
  String? info;
  double? lat;
  double? long;
  CityModel? city;

  StoreModel(this.id, this.name, this.address, this.info, this.lat, this.long,
      this.city);

  StoreModel.fronJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqName = json['uniq_name'];
    name = json['name'];
    address = json['address'];
    info = json['info'] ?? '';
    lat = json['lat'];
    long = json['long'];
    image = json['image'];
    city = CityModel.fromJson(json['city']);
  }
}
