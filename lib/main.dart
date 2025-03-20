import 'package:catinder/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Tinder',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CatHomePage(),
    );
  }
}
