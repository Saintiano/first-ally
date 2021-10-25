import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/complete_setup.dart';
import 'views/create_account.dart';
import 'views/intro.dart';
import 'views/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'First Ally Test App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: const Intro(),
    );
  }
}

