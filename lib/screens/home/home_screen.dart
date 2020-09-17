import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/di/service_locator.dart';
import 'package:my_facebook/res/strings.dart';
import 'package:my_facebook/screens/home/add_post_container.dart';
import 'package:my_facebook/screens/home/post_container.dart';
import 'package:my_facebook/utils/error_screen.dart';
import 'package:my_facebook/utils/loading_screen.dart';
import 'package:my_facebook/utils/response_state.dart';
import 'package:my_facebook/view_model/posts_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostViewModel viewModel = serviceLocator<PostViewModel>();

  int offset = 0;
  int limit = 25;
  bool isMoreDataAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(Strings.appTitle),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<PostViewModel>(
        create: (context) => viewModel..fetchHomeScreenData(),
        builder: (context, _) {
          return Consumer<PostViewModel>(builder: (context, viewModel, _) {
            switch (viewModel.postDataUseCase.state) {
              case ResponseState.LOADING:
                return LoadingScreen();
                break;
              case ResponseState.ERROR:
                return ErrorScreen(viewModel.postDataUseCase.exception);
                break;
              case ResponseState.COMPLETE:
                return _getProfileList(context, viewModel.postDataUseCase.data);
                break;
            }
            return Container();
          });
        },
      ),
    );
  }

  Widget _getProfileList(BuildContext context, List<Post> posts) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if (isMoreDataAvailable) {
          viewModel.fetchMoreData();
          setState(() {});
        }
      }
    });

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: AddPostContainer(
          onAdd: (post) {
            Provider.of<PostViewModel>(context, listen: false).addPost(post);
            return Navigator.pop(context);
          },
        )),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final Post post = posts[index];
            return PostContainer(
              post: post,
            );
          }, childCount: posts.length),
        ),
        SliverToBoxAdapter(child: _getLoadMoreContainer()),
      ],
    );
  }

  Widget _getLoadMoreContainer() {
    return Consumer<PostViewModel>(builder: (context, viewModel, _) {
      if (viewModel.isMoreDataAvailableUseCase.state == ResponseState.COMPLETE) {
        isMoreDataAvailable = viewModel.isMoreDataAvailableUseCase.data;
        if (isMoreDataAvailable == true) {
          return Container(
            height: 50.0,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          );
        }
      }
      return SizedBox.shrink();
    });
  }
}
