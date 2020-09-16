class ImageModel {
  String path;
  bool isSynced;

  ImageModel({this.path, this.isSynced: true});

  ImageModel.fromJson(Map<String, dynamic> json)
      : path = json['path'],
        isSynced = json['isSynced'];
}
