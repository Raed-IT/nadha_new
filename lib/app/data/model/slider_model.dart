class SliderModel {
  String? url;
  String? image;

  SliderModel(this.url, this.image);

  SliderModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    image = json['img'];
  }
}
