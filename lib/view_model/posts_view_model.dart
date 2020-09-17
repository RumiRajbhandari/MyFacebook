import 'package:flutter/foundation.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/di/service_locator.dart';
import 'package:my_facebook/repository/home_repository.dart';
import 'package:my_facebook/utils/response.dart';

class PostViewModel extends ChangeNotifier {
  HomeRepository _homeRepository = serviceLocator<HomeRepository>();

  List<Post> postList = new List();
  int offset = 0;
  int limit = 25;
  bool isMoreDataAvailable = true;

  Response<List<Post>> postDataUseCase = Response<List<Post>>();
  Response<bool> isMoreDataAvailableUseCase = Response<bool>();

  void _setPostsDataUseCase(Response response) {
    postDataUseCase = response;
    notifyListeners();
  }

  void _setisMoreDataAvailableUseCase(Response response) {
    isMoreDataAvailableUseCase = response;
    notifyListeners();
  }

  Future<void> fetchHomeScreenData() async {
    _setPostsDataUseCase(Response.loading<List<Post>>());
    try {
      var homeRemoteModel = await _homeRepository.fetchHomeScreenData();
      offset = homeRemoteModel.posts.length;
      if (homeRemoteModel.posts.length < limit) {
        isMoreDataAvailable = true;
        _setisMoreDataAvailableUseCase(Response.complete<bool>(false));
      } else {
        isMoreDataAvailable = false;
        _setisMoreDataAvailableUseCase(Response.complete<bool>(true));
      }
      addAllPosts(homeRemoteModel.posts);
    } catch (exception) {
      _setPostsDataUseCase(Response.error<List<Post>>(exception.toString()));
    }
  }

  Future<void> fetchMoreData() async {
    try {
      var posts = await _homeRepository.fetchMorePostData(limit, offset);
      offset += posts.length;
      if (posts.length < limit) {
        _setisMoreDataAvailableUseCase(Response.complete<bool>(false));
      } else {
        _setisMoreDataAvailableUseCase(Response.complete<bool>(true));
      }
      addAllPosts(posts);
    } catch (exception) {
      _setisMoreDataAvailableUseCase(Response.complete<bool>(false));
    }
  }

  void addAllPosts(List<Post> posts) {
    postList.addAll(posts);
    _setPostsDataUseCase(Response.complete<List<Post>>(postList));
  }

  void addPost(Post post) {
    postList.insert(0, post);
    _setPostsDataUseCase(Response.complete<List<Post>>(postList));
  }
}
