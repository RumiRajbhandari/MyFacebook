import 'package:get_it/get_it.dart';
import 'package:my_facebook/remote/home_remote.dart';
import 'package:my_facebook/remote/home_remote_impl.dart';
import 'package:my_facebook/repository/home_repository.dart';
import 'package:my_facebook/repository/home_repository_impl.dart';
import 'package:my_facebook/view_model/home_view_model.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  serviceLocator.registerLazySingleton<HomeRemote>(() => HomeRemoteImpl());

  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
}
