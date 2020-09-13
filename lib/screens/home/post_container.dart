import 'package:flutter/material.dart';
import 'package:my_facebook/data/post.dart';
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
            //todo rumi
            Container(
              height: 1,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(post.title),
            ),
            (post.imageList != null && post.imageList.length > 0)
                ? _getImageBody(post.imageList)
                : const SizedBox.shrink()
          ],
        ));
  }

  Widget _getImageBody(List<String> imageList) {
    return (imageList.length > 1) ? _getGridView(imageList) : Image.network(imageList[0]);
  }

  Widget _getGridView(List<String> imageList) {
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
                    image:
                        DecorationImage(image: NetworkImage(imageList[index]), fit: BoxFit.fill)),
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
            child: Image.network(imageList[index]),
            fit: BoxFit.fill,
          );
        }
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 10, childAspectRatio: 1.5),
    );
  }
}
