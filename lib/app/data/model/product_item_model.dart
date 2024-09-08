class ProductItemModel {
  int? id;
  String? store;
  String? name;
  String? unitName;
  String? img;

  ProductItemModel({this.id, this.store, this.name, this.unitName, this.img});

  ProductItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    store = json['store'];
    name = json['name'];
    unitName = json['unit_name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store'] = this.store;
    data['name'] = this.name;
    data['unit_name'] = this.unitName;
    data['img'] = this.img;
    return data;
  }
}