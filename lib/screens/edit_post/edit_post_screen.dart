import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_facebook/data/model/image.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/res/color.dart';
import 'package:my_facebook/res/strings.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';
import 'package:my_facebook/view_model/posts_view_model.dart';
import 'package:toast/toast.dart';

class EditPostScreen extends StatefulWidget {
  final void Function(Post post) onEdit;
  final Post post;

  EditPostScreen({@required this.post, @required this.onEdit});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  List<Asset> imageAssets = List<Asset>();
  final PostViewModel viewModel = PostViewModel();
  String updatedStatus;

  Future getImage() async {
    try {
      var selectedImage = await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true);
      imageAssets.addAll(selectedImage);
      widget.post.imageList.addAll(_getImageList());
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(Strings.editPost),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    ProfileAvatar(),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(child: Text('Rumi Rajbhandari')),
                  ],
                ),
                BgItem(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                      maxLines: 3,
                      onChanged: (String value) {
                        updatedStatus = value;
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: Strings.whatsonYourMind, hintStyle: TextStyle(fontSize: 16)),
                      controller: TextEditingController.fromValue(TextEditingValue(
                          text: widget.post.status,
                          selection: TextSelection.collapsed(offset: widget.post.status.length)))),
                ),
                _getGridView(),
                _getButtons()
              ],
            ),
          ),
        ));
  }

  Widget _getGridView() {
    var imageList = widget.post.imageList;
    return (imageList == null || imageList.length < 1)
        ? SizedBox.shrink()
        : GridView.count(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20),
            shrinkWrap: true,
            crossAxisCount: 3,
            children: List.generate(imageList.length, (index) {
              return _getSingleImageView(imageList[index]);
            }),
          );
  }

  Widget _getButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(
            color: color_accent,
            child: Text(Strings.pickImages,
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14)),
            onPressed: () {
              getImage();
            },
          ),
          FlatButton(
            color: color_accent,
            child: Text(Strings.update,
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14)),
            onPressed: () {
              if ((updatedStatus != null && updatedStatus != widget.post.status) ||
                  imageAssets.length > 0) {
                widget.post.status = updatedStatus;
                widget.onEdit(widget.post);
              } else {
                Toast.show(Strings.pleaseEditPostBeforeUpdating, context);
              }
            },
          )
        ],
      ),
    );
  }

  List<ImageModel> _getImageList() {
    return imageAssets
        .map(
            (image) => ImageModel(asset: image, isSynced: false, file: File("${image.identifier}")))
        .toList();
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
      return Image.network(
        imageModel.path,
        fit: BoxFit.fitHeight,
      );
    }
  }
}
