import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/remote/api_service.dart';
import 'package:my_facebook/remote/home_remote.dart';

class HomeRemoteImpl implements HomeRemote {
  ApiService _apiService = ApiService();

  @override
  Future<HomeRemoteModel> fetchHomeScreenData() async {
    final reponse = await _apiService.get('home');
    return HomeRemoteModel.fromJson(reponse);
  }
}
