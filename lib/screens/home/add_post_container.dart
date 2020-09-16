import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/screens/add_post/add_post_screen.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';
import 'package:my_facebook/view_model/posts_view_model.dart';
import 'package:provider/provider.dart';

class AddPostContainer extends StatelessWidget {
  final void Function(Post post) onEdit;

  AddPostContainer({@required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostViewModel>(
        create: (context) => PostViewModel(),
        builder: (context, _) {
          return BgItem(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                ProfileAvatar(),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: BgItem(
                    margin: EdgeInsets.all(12),
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      decoration: InputDecoration.collapsed(hintText: 'What\'s on your mind?'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostScreen(
                              onEdit: (post) {
                                onEdit(post);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
