import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/common/ClientSpace.dart';
import 'package:ajiapp/settings/fonts.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: myFonts.fontFamily,
      ),
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: Clientspace(),
    );
  }
}
