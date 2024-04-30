class SliderModel {
  int? id;

  String? image;
  String? url;
  bool? status;

  SliderModel(this.id, this.image, this.url);

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    image = json['image'];
    url = json['url'];
  }
}
