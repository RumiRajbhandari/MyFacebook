import 'package:flutter/material.dart';
import 'package:my_facebook/data/model/image.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/res/color.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/post_header.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  // todo rumi
  const PostContainer({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BgItem(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PostHeader(post: post),
            Container(
              height: 1,
              color: color_divider,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.status),
            ),
            (post.imageList != null && post.imageList.length > 0)
                ? _getImageBody(post.imageList)
                : const SizedBox.shrink()
          ],
        ));
  }

  Widget _getImageBody(List<ImageModel> imageList) {
    return (imageList.length > 1) ? _getGridView(imageList) : Image.network(imageList[0].path);
  }

  Widget _getGridView(List<ImageModel> imageList) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (imageList.length > 4) ? 4 : imageList.length,
      itemBuilder: (context, index) {
        if (index == 3 && imageList.length > 4) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageList[index].path), fit: BoxFit.cover)),
              ),
              Container(
                color: Color.fromRGBO(0, 0, 0, 0.4),
              ),
              Center(
                child: Text(
                  'More',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          );
        } else {
          return FittedBox(
            child: Image.network(imageList[index].path),
            fit: BoxFit.fill,
          );
        }
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 10, childAspectRatio: 1.5),
    );
  }
}
