
import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';

class ImageModel {
  String path;
  bool isSynced;
  Asset asset;
  File file;

  ImageModel({this.path, this.isSynced: true, this.asset, this.file});

  ImageModel.fromJson(Map<String, dynamic> json)
      : path = json['path'],
        isSynced = json['isSynced'];
}
