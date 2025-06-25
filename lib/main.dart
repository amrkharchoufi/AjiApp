import 'package:ajiapp/init_binding.dart';
import 'package:ajiapp/routing.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:ajiapp/settings/fonts.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // This preserves the splash screen until initialization is complete
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Lock orientation for better performance
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.instance.initialize();
  // Remove the splash screen when initialization is complete
  FlutterNativeSplash.remove();

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return GetMaterialApp(
      title: 'Aji App',
      initialBinding: InitBindings(),
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
            seedColor: const Color(0xFF98161b), primary: ajired),
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
