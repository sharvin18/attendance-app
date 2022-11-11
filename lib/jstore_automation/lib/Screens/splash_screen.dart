<<<<<<< HEAD
import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Screens/signIn.dart';
=======
import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Screens/Home.dart';
import 'package:marku/Screens/signIn.dart';
>>>>>>> version-upgrade
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
<<<<<<< HEAD
import 'home.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
=======

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
>>>>>>> version-upgrade

  @override
  void initState(){
    super.initState();
<<<<<<< HEAD

    checkTime().then(
        (status){
=======
    print("STARTING CHECKING GET TEACHER METHOD");
    checkTime().then(
            (status){
              print("GET TEACHER METHOD IS DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
>>>>>>> version-upgrade
          navigation();
        }
    );
  }

  Future<bool> checkTime() async {
    await Future.delayed(Duration(seconds: 1), () async {
      await getTeacher().then((value) => existence == true? appTheme(themeColor): null);
    });

    return true;
  }

  void navigation(){

    Navigator.of(context).pushReplacement(
<<<<<<< HEAD
      MaterialPageRoute(
        builder: (BuildContext context) => FirebaseAuth.instance.currentUser != null
            ? Home()
            : SignIn(),
      )
=======
        MaterialPageRoute(
          builder: (BuildContext context) => FirebaseAuth.instance.currentUser != null
              ? Home()
              : SignIn(),
        )
>>>>>>> version-upgrade
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FooterView(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    GradientText(
                        'MarkU',
                        gradient: LinearGradient(colors: [
                          Color(0xFF3a5af9), Color(0xFF7449fa)
                        ]),
                        style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: "Bold",
                        )
                    ),
<<<<<<< HEAD
                    SizedBox(height: 20.0,),
                    Text(
=======
                    const SizedBox(height: 20.0,),
                    const Text(
>>>>>>> version-upgrade
                        'The Ultimate attendance app',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: "Bold",
                        )
                    ),
<<<<<<< HEAD
                    SizedBox(height: 100.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitRing(color: Colors.blue[700], size: 40, lineWidth: 5,)
=======
                    const SizedBox(height: 100.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitRing(color: Colors.blue[700]!, size: 40, lineWidth: 5,)
>>>>>>> version-upgrade
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
        footer: new Footer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "2021 \u00a9 GenCoders",
                    style: TextStyle(
<<<<<<< HEAD
                      color: Colors.indigo[500],
=======
                      color: Colors.indigo[500]!,
>>>>>>> version-upgrade
                      fontFamily: "Bold",
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
<<<<<<< HEAD
              SizedBox(height: 15),
=======
              const SizedBox(height: 15),
>>>>>>> version-upgrade
            ],
          ),
        ),
        flex: 2,
      ),
    );
  }
}
