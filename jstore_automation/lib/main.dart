import 'package:animations/animations.dart';
<<<<<<< HEAD
import 'package:attendance_app/Authentication/auth.dart';
import 'package:attendance_app/Screens/signIn.dart';
import 'package:attendance_app/Screens/splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
import 'package:marku/Screens/splash_screen.dart';
import 'package:camera/camera.dart';
>>>>>>> version-upgrade
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Authentication/dbdata.dart';
<<<<<<< HEAD
import 'Helpers/constants.dart';
import 'Screens/home.dart';
=======

>>>>>>> version-upgrade

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    cameras = await availableCameras();
  }catch (e) {
    print(e);
  }
  await Firebase.initializeApp();
  loading = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance App',
      theme: ThemeData(

        textTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: "Bold",
            fontSize: 18.0,
          ),
        ),

        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
            TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
          },
        ),
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

<<<<<<< HEAD
      home: splashScreen(),
=======
      home: SplashScreen(),
>>>>>>> version-upgrade

      debugShowCheckedModeBanner: false,
    );
  }
}