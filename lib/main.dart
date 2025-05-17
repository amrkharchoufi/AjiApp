import 'dart:io';

import 'package:ajiapp/routing.dart';
import 'package:ajiapp/settings/fonts.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation for better performance
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize WebView platform
  _initializeWebView();

  // Run the app - removed precaching as it needs context
  runApp(const MyApp());
}

// Initialize WebView platform
void _initializeWebView() {
  if (WebViewPlatform.instance == null) {
    if (Platform.isIOS || Platform.isMacOS) {
      WebViewPlatform.instance = WebKitWebViewPlatform();
    } else if (Platform.isAndroid) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GetMaterialApp(
      title: 'Aji App',
      theme: ThemeData(
        fontFamily: myFonts.fontFamily,
        // Optimize material animations
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        // Use the system's color scheme for better performance
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF98161b),
        ),
        useMaterial3: true,
      ),
      getPages: routes,
      initialRoute: Routes.SPLASH,
      debugShowCheckedModeBanner: false,

      // Use faster transition
      // defaultTransition: Transition.fade,
      customTransition: ScaleTransitions(),
      transitionDuration: const Duration(milliseconds: 200),

      // Optimize GetX for performance
      enableLog: false,
      opaqueRoute: true,
      popGesture: true,
      defaultGlobalState: false,
    );
  }
}

// Custom transition with optimized animation
class ScaleTransitions extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // Use a simpler animation for better performance
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: curve ?? Curves.easeOutQuad,
      ),
      child: child,
    );
  }
}
