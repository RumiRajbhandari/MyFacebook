import 'package:flutter/foundation.dart';
import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/di/service_locator.dart';
import 'package:my_facebook/repository/home_repository.dart';
import 'package:my_facebook/utils/response.dart';

class HomeViewModel extends ChangeNotifier {
  HomeRepository _homeRepository = serviceLocator<HomeRepository>();

  Response<HomeRemoteModel> homeDataUseCase = Response<HomeRemoteModel>();

  void _setHomeScreenDataUseCase(Response response) {
    homeDataUseCase = response;
    notifyListeners();
  }

  Future<void> fetchHomeScreenData() async {
    _setHomeScreenDataUseCase(Response.loading<HomeRemoteModel>());
    try {
      _homeRepository
          .fetchHomeScreenData()
          .then((value) => _setHomeScreenDataUseCase(Response.complete<HomeRemoteModel>(value)));
    } catch (exception) {
      _setHomeScreenDataUseCase(Response.error<HomeRemoteModel>(exception.toString()));
    }
  }
}
