import 'package:my_facebook/data/model/home_remote_model.dart';

abstract class HomeRemote{
  Future<HomeRemoteModel> fetchHomeScreenData();

}