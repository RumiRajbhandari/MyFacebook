import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_facebook/res/color.dart';

class BgItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;

  BgItem({@required this.child, this.padding, this.margin});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Card(
          color: main_background,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          margin: margin ?? const EdgeInsets.all(0),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(0),
            child: child,
          )),
    );
  }
}
