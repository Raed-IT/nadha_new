import 'package:delevary/app/Data/Models/BaseModel.dart';
import 'package:delevary/app/Data/Models/MediaModel.dart';

class CategoryModel extends BaseModel {
  String? name;
  int? order;
  int? parentId;
  bool? status;
  String? createdAt;
  bool? hasChildren;
  bool? isShowTime;
  String? image;
  List<MediaModel>? images;

  CategoryModel(
      {id,
      this.name,
      this.order,
      this.parentId,
      this.status,
      this.createdAt,
      this.hasChildren});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    images = [];
    if (json['images'].length > 0) {
      json['images'].keys!.forEach((key) {
        int id = int.parse("$key");
        String image = json['images'][key];
        images!.add(MediaModel(id, image));
      });
    }

    id = json['id'];
    name = json['name'];
    isShowTime = json['is_show_time'];
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
