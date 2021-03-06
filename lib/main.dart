import 'package:flutter/material.dart';

import 'ui/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Demo Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const HomePage(),
    );
  }
}

