import 'package:flutter/material.dart';
import 'package:my_facebook/data/post.dart';
import 'package:my_facebook/screens/home/add_post_container.dart';
import 'package:my_facebook/screens/home/post_container.dart';

class HomeScreen extends StatelessWidget {
  var postList = [
    Post(id: 1, title: "Hello world", imageList: []),
    Post(id: 1, title: "Hello world", imageList: [
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png'
    ]),
    Post(id: 2, title: "This is post 2", imageList: [
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png',
      'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png'
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              final Post post = postList[index];
              return PostContainer(
                post: post,
              );
            }, childCount: postList.length),
          )
        ],
      ),
    );
  }
}
