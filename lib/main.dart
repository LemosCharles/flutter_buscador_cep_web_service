import 'package:flutter/material.dart';
import 'package:web_service/views/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    theme:
        ThemeData(brightness: Brightness.light, primarySwatch: Colors.blueGrey),
    darkTheme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}
