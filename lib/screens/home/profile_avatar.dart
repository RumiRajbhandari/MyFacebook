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
          'https://raw.githubusercontent.com/RumiRajbhandari/NavigationComponentDemo/master/media/rara.png'),
    );
  }
}
