import 'package:flutter/foundation.dart';
import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/di/service_locator.dart';
import 'package:my_facebook/repository/home_repository.dart';
import 'package:my_facebook/utils/response.dart';

class PostViewModel extends ChangeNotifier {
  HomeRepository _homeRepository = serviceLocator<HomeRepository>();

  List<Post> postList = new List();

  Response<HomeRemoteModel> homeDataUseCase = Response<HomeRemoteModel>();
  Response<List<Post>> postDataUseCase = Response<List<Post>>();

  void _setHomeScreenDataUseCase(Response response) {
    homeDataUseCase = response;
    notifyListeners();
  }

  void _setPostsDataUseCase(Response response) {
    postDataUseCase = response;
    notifyListeners();
  }

  Future<void> fetchHomeScreenData() async {
    _setPostsDataUseCase(Response.loading<List<Post>>());
    try {
      var homeRemoteModel = await _homeRepository.fetchHomeScreenData();
      addAllPosts(homeRemoteModel.posts);
    } catch (exception) {
      _setHomeScreenDataUseCase(Response.error<List<Post>>(exception.toString()));
    }
  }

  void addAllPosts(List<Post> posts) {
    postList.addAll(posts);
    _setPostsDataUseCase(Response.complete<List<Post>>(postList));
    print('add All post ----- ${postList.length}');

  }

  void addPost(Post post) {
    postList.insert(0, post);
    _setPostsDataUseCase(Response.complete<List<Post>>(postList));
    print('add post ----- ${postList.length}');

  }
}
