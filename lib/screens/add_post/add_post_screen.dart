import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_facebook/data/model/image.dart';
import 'package:my_facebook/data/model/post.dart';
import 'package:my_facebook/res/color.dart';
import 'package:my_facebook/res/strings.dart';
import 'package:my_facebook/screens/home/bg_item.dart';
import 'package:my_facebook/screens/home/profile_avatar.dart';
import 'package:toast/toast.dart';

class AddPostScreen extends StatefulWidget {
  final void Function(Post post) onAdd;

  AddPostScreen({@required this.onAdd});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  List<Asset> images = List<Asset>();

  String status = "";

  Future getImage() async {
    try {
      images = await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true);
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
          title: Text(Strings.addNewPost),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(12),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      ProfileAvatar(),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(child: Text('Rumi Rajbhandari')),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: BgItem(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      maxLines: 3,
                      onChanged: (String value) {
                        status = value;
                      },
                      decoration: InputDecoration.collapsed(
                          hintText: Strings.whatsonYourMind, hintStyle: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return _getSingleImageView(images[index]);
                    }, childCount: images.length)),
                SliverToBoxAdapter(child: _getButtons())
              ],
            )));
  }

  Widget _getSingleImageView(Asset asset) {
    return AssetThumb(
      asset: asset,
      width: 300,
      height: 300,
      spinner: Container(),
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
            child: Text(Strings.post,
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 14)),
            onPressed: () {
              if (status.isEmpty && images.length < 1) {
                Toast.show(Strings.pleaseAddStatusOrImagesBeforePosting, context);
              } else {
                var post = Post(id: 0, status: status, imageList: _getImageList());
                widget.onAdd(post);
              }
            },
          )
        ],
      ),
    );
  }

  List<ImageModel> _getImageList() {
    return images
        .map(
            (image) => ImageModel(asset: image, isSynced: false, file: File("${image.identifier}")))
        .toList();
  }
}
