import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/home_remote_model.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/screens/home/add_post_container.dart';
import 'package:my_facebook/screens/home/post_container.dart';
import 'package:my_facebook/utils/error_screen.dart';
import 'package:my_facebook/utils/loading_screen.dart';
import 'package:my_facebook/utils/response_state.dart';
import 'package:my_facebook/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*var postList = [
    Post(id: 1, status: "Hello world", imageList: []),
    Post(id: 1, status: "Hello world", imageList: [
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png'
    ]),
    Post(id: 2, status: "This is post 2", imageList: [
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png'
    ]),
  ];*/

  final HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.fetchHomeScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
          switch (viewModel.homeDataUseCase.state) {
            case ResponseState.LOADING:
              return LoadingScreen();
              break;
            case ResponseState.ERROR:
              return ErrorScreen(viewModel.homeDataUseCase.exception);
              break;
            case ResponseState.COMPLETE:
              print('home data is ${viewModel.homeDataUseCase.data.posts}');
              return _getProfileList(viewModel.homeDataUseCase.data);
              break;
          }
          return Container();
        }),
      ),
    );
  }

  Widget _getProfileList(HomeRemoteModel homeRemoteModel) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text("My facebook", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          floating: true,
        ),
        SliverToBoxAdapter(child: AddPostContainer()),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final Post post = homeRemoteModel.posts[index];
            return PostContainer(
              post: post,
            );
          }, childCount: homeRemoteModel.posts.length),
        )
      ],
    );
  }
}
