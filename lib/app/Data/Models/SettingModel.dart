class SettingModel {
  int? id;
  String? address;
  bool? isClose;
  double? exchange;
  int? longitude;
  double? latitude;
  String? email;
  String? img;
  String? subEmail;
  String? phone;
  String? subPhone;
  String? twitter;
  String? face;
  String? instagram;
  String? youtube;
  String? linkedin;
  String? privacy;
  String? createdAt;
  String? updatedAt;

  SettingModel(
      {this.id,
      this.address,
        this.exchange,
      this.isClose,
      this.longitude,
      this.latitude,
      this.email,
      this.img,
      this.subEmail,
      this.phone,
      this.subPhone,
      this.twitter,
      this.face,
      this.instagram,
      this.youtube,
      this.linkedin,
      this.privacy,
      this.createdAt,
      this.updatedAt});

  SettingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    isClose = json['is_close'];
    longitude = json['longitude'];
    exchange = double.tryParse("${json['exchange']}");
    latitude = json['latitude'];
    email = json['email'];
    img = json['img'];
    subEmail = json['sub_email'];
    phone = json['phone'];
    subPhone = json['sub_phone'];
    twitter = json['twitter'];
    face = json['face'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    linkedin = json['linkedin'];
    privacy = json['privacy'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
