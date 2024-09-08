import 'package:get/get.dart';

import '../inital/main_controller.dart';

class StoreModel {
  int? id;
  String? name;
  String? whats;
  String? address;
  String? img;

  StoreModel({this.id, this.name, this.whats, this.address, this.img});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
     name = json['name'];
    whats = json['whats'];
    address = json['address'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['whats'] = this.whats;
    data['address'] = this.address;
    data['img'] = this.img;
    return data;
  }
}
