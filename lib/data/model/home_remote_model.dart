import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/data/model/user.dart';

class HomeRemoteModel {
  User currentUser;
  List<Post> posts;

  HomeRemoteModel.fromJson(Map<String, dynamic> json)
      : currentUser = User.fromJson(json['currentUser'] as Map<String, dynamic>),
        posts = (json['posts'] as List)
            ?.map((e) => e == null ? null : Post.fromJson(e as Map<String, dynamic>))
            ?.toList();
}
