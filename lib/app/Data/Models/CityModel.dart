import 'package:delevary/app/Data/Models/BaseModel.dart';

class CityModel extends BaseModel {
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  CityModel({this.name, this.status, this.createdAt, this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String? getTitle() {
    return name;
  }

  @override
  String? getImage() {
    throw UnimplementedError();
  }
}
