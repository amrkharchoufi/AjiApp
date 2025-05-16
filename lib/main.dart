<<<<<<< Updated upstream
=======
import 'dart:io';

import 'package:ajiapp/routing.dart';

>>>>>>> Stashed changes
import 'package:ajiapp/settings/fonts.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/views/common/ClientSpace.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
>>>>>>> Stashed changes
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (WebViewPlatform.instance == null) {
    if (Platform.isIOS || Platform.isMacOS) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    } else if (Platform.isAndroid) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: myFonts.fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      home:Clientspace(),
    );
  }
}
