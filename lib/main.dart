import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/ClientSpace.dart';
import 'package:ajiapp/views/homepage_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Clientspace(),
    );
  }
}
