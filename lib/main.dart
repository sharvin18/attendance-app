import 'package:animations/animations.dart';
import 'package:attendance_app/Authentication/auth.dart';
import 'package:attendance_app/Screens/signIn.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Authentication/dbdata.dart';
import 'Screens/home.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }catch (e) {
    print(e);
  }
  await Firebase.initializeApp();
  await getTeacher();
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

      home: FirebaseAuth.instance.currentUser != null
          ? Home()
          : SignIn(),

      debugShowCheckedModeBanner: false,
    );
  }
}