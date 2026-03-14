import 'package:flutter/material.dart';
import 'package:learn_apis/signUp.dart';

import 'example_three.dart';
import 'example_two.dart';
import 'posts_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  Signup(),
      debugShowCheckedModeBanner: false,
    );
  }
}
