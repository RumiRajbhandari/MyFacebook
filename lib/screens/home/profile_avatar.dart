import 'package:flutter/material.dart';
import 'package:my_facebook/res/color.dart';

class ProfileAvatar extends StatelessWidget {
  String imageUrl;

  ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: main_background,
      backgroundImage: NetworkImage(
          'https://cdn.pixabay.com/photo/2015/09/02/13/24/girl-919048_1280.jpg'),
    );
  }
}
