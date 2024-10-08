class AddressModel {
  int? id;
  String? name;
  String? address;
  double? latitude;
  double? longitude;

  AddressModel(
      {this.id, this.name, this.address, this.latitude, this.longitude});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    latitude = double.tryParse(json['latitude'].toString());
    longitude = double.tryParse(json['longitude'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
