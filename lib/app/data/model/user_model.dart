class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? level;
  String? status;
  String? storeName;
  String? address;
  String? marketName;
  String? whats;
  String? face;
  int? cityId;
  double? totalBalance;
  double? totalPoint;
  bool? isClose;

  UserModel({
    this.id,
    this.name,
    this.marketName,
    this.isClose,
    this.email,
    this.username,
    this.level,
    this.status,
    this.storeName,
    this.address,
    this.whats,
    this.face,
    this.cityId,
    this.totalBalance,
    this.totalPoint,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isClose = bool.tryParse("${json['is_close']}") ?? false;
    email = json['email'];
    username = json['username'];
    level = json['level'];
    status = json['status'];
    storeName = json['store_name'];
    marketName = json['market_name'];
    address = json['address'];
    whats = json['whats'];
    face = json['face'];
    cityId = int.tryParse(json['city_id'].toString());
    totalBalance = double.tryParse(json['total_balance'].toString()) ?? 0;
    totalPoint = double.tryParse(json['total_point'].toString()) ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['level'] = this.level;
    data['status'] = this.status;
    data['store_name'] = this.storeName;
    data['address'] = this.address;
    data['whats'] = this.whats;
    data['face'] = this.face;
    data['city_id'] = this.cityId;
    data['is_close'] = this.isClose;
    return data;
  }
}
