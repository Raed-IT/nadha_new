import 'package:delevary/app/Data/Models/BaseModel.dart';

class CategoryModel extends BaseModel {
  int? id;
  String? name;
  int? order;
  int? parentId;
  bool? status;
  String? createdAt;
  bool? hasChildren;
  String? image;

  CategoryModel(
      {this.id,
      this.name,
      this.order,
      this.parentId,
      this.status,
      this.createdAt,
      this.hasChildren});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    order = json['order'];
    parentId = json['parent_id'];
    status = json['status'];
    createdAt = json['created_at'];
    hasChildren = json['has_children'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['parent_id'] = this.parentId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['has_children'] = this.hasChildren;
    return data;
  }

  @override
  String? getTitle() {
    return name;
  }

  @override
  String? getImage() {
    return image;
  }
}
