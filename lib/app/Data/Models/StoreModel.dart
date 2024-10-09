import 'package:delevary/app/Data/Models/CityModel.dart';

class StoreModel {
  int? id;
  String? name;
  String? uniqName;
  String? address;
  String? closeAt;
  String? openAt;
  String? image;
  String? info;
  double? lat;
  double? long;
  CityModel? city;
  bool? isOpen;
  bool? autoClose;

  StoreModel(this.id, this.name, this.address, this.info, this.lat, this.long,
      this.city);

  StoreModel.fromJson(Map<String, dynamic> json) {
    autoClose = json['auto_close'];
    id = json['id'];
    uniqName = json['uniq_name'];
    name = json['name'];
    isOpen = json['is_open'];
    address = json['address'];
    closeAt = json['close_at'];
    openAt = json['open_at'];
    info = json['info'] ?? '';
    lat = double.tryParse("${json['lat']}");
    long = double.tryParse("${json['long']}");
    image = json['image'];
    city = CityModel.fromJson(json['city']);
  }
}
