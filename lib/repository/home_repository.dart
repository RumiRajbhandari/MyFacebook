import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/data/model/post.dart';

abstract class HomeRepository {
  Future<HomeRemoteModel> fetchHomeScreenData();
  Future<List<Post>> fetchMorePostData(int limit, int offset);
}
