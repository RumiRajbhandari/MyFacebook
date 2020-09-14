import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/di/service_locator.dart';
import 'package:my_facebook/remote/home_remote.dart';
import 'package:my_facebook/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRemote _homeRemote = serviceLocator<HomeRemote>();

  @override
  Future<HomeRemoteModel> fetchHomeScreenData() {
    return _homeRemote.fetchHomeScreenData();
  }
}
