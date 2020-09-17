import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/res/strings.dart';
import 'package:my_facebook/screens/add_post/add_post_screen.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';

class AddPostContainer extends StatelessWidget {
  final void Function(Post post) onAdd;

  AddPostContainer({@required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return BgItem(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          ProfileAvatar(),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              child: BgItem(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(8),
                child: Text(Strings.whatsonYourMind),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPostScreen(
                      onAdd: (post) {
                        onAdd(post);
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
