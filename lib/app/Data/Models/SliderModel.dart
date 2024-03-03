class SliderModel {
  int? id;

  String? image;
  String? url;

  SliderModel(this.id, this.image, this.url);

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
  }
}
