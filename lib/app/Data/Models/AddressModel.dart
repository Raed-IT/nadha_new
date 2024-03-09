class AddressModel {
  int? id;
  String? name;
  double? lat;
  double? long;
  String? info;

  AddressModel(this.id, this.name, this.lat, this.long, this.info);

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lat = double.tryParse("${json['lat']}");
    long = double.tryParse("${json['long']}");
    info = json['info'];
  }
}
