import 'package:flutter/material.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';

class AddPostContainer extends StatelessWidget {
//  final User user;

//  AddPostContainer({this.user});
  @override
  Widget build(BuildContext context) {
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
