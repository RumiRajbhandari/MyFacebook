import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/screens/edit_post/edit_post_screen.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';

class PostHeader extends StatelessWidget {
  final Post post;
  final void Function(Post post) onEdit;

  const PostHeader({Key key, @required this.post, @required this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Row(
        children: [
          ProfileAvatar(),
          const SizedBox(
            width: 12,
          ),
          Expanded(child: Text('Rumi Rajbhandari')),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPostScreen(
                    post: post,
                    onEdit: (post) {
                      onEdit(post);
                    },
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
