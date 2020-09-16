import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/res/color.dart';

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
  final PostViewModel viewModel = PostViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: main_background,
          title: Text("My facebook", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          floating: true,
        ),
        SliverToBoxAdapter(child: AddPostContainer(
          onEdit: (post) {
            final model = Provider.of<PostViewModel>(context, listen: false);
            final todo = model.addPost(post);
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
        )
      ],
    );
  }
}
