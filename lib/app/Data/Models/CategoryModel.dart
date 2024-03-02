class CategoryModel {
  int? id;
  String? name;
  int? order;
  int? parentId;
  bool? status;
  String? createdAt;
  bool? hasChildren;

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
}