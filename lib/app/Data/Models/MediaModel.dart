class MediaModel {
  int? id ;
  String? url ;

  MediaModel(this.id, this.url);
  MediaModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    url=json['url'];
  }
}