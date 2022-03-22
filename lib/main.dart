// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:mainlogin/other/login.dart';
import 'package:mainlogin/other/register.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'mainfile/homepage.dart';
import 'other/ui_front.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoginUI',
      home: HomePage(),
    );
  }
}

