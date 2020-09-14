import 'package:my_facebook/data/model/user.dart';

class Post {
  int id;
  String status;
  User user;
  List<String> imageList;

  Post({this.id, this.status, this.imageList});

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        status = json['status'],
        user = User.fromJson(json['user'] as Map<String, dynamic>),
        imageList =
            (json['imageList'] as List)?.map((e) => e == null ? null : e.toString())?.toList();
}
