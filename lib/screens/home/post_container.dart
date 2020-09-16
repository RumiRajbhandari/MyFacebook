import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
              child: (post.status != null && post.status.isNotEmpty)
                  ? Text(post.status)
                  : SizedBox.shrink(),
            ),
            (post.imageList != null && post.imageList.length > 0)
                ? _getImageBody(context, post.imageList)
                : const SizedBox.shrink()
          ],
        ));
  }

  Widget _getImageBody(BuildContext context, List<ImageModel> imageList) {
    return (imageList.length > 1)
        ? _getGridView(context, imageList)
        : _getSingleImageView(imageList[0]);
  }

  Widget _getSingleImageView(ImageModel imageModel) {
    if (imageModel.asset != null) {
      return AssetThumb(
        asset: imageModel.asset,
        width: 300,
        height: 300,
        spinner: Container(),
      );
    } else {
      return Image.network(imageModel.path);
    }
  }

  Widget _getGridView(BuildContext context, List<ImageModel> imageList) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: (imageList.length > 4) ? 4 : imageList.length,
        itemBuilder: (context, index) {
          var image = imageList[index];
          if (index == 3 && imageList.length > 4) {
            return Stack(
              children: [
                Container(
                  child: (image.path != null && image.path.isNotEmpty)
                      ? Image.network(image.path)
                      : AssetThumb(
                    asset: image.asset,
                    width: 300,
                    height: 300,
                    spinner: Container(),
                  ),
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
              child: (image.asset != null)
                  ? AssetThumb(
                asset: image.asset,
                width: 300,
                height: 300,
                spinner: Container(),
              )
                  : Image.network(image.path),
              fit: BoxFit.fill,
            );
          }
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.5),
      ),
    );
  }
}
