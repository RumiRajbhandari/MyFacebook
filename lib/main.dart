import 'package:flutter/material.dart';
import 'package:my_facebook/screens/home/home_screen.dart';

import 'di/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(MaterialApp(
    title: "My Facebook",
    routes: {'/': (context) => HomeScreen()},
  ));
}
