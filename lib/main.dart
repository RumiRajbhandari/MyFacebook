import 'package:flutter/material.dart';
import 'package:my_facebook/screens/home/home_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "My Facebook",
    routes: {'/': (context) => HomeScreen()},
  ));
}
