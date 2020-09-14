import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';

class PostHeader extends StatelessWidget {
  final Post post;

  const PostHeader({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Row(
        children: [
          ProfileAvatar(),
          const SizedBox(
            width: 8,
          ),
          Expanded(child: Text('Rumi Rajbhandari')),
          IconButton(
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
    );
  }
}
