import 'package:attendance_app/Authentication/auth.dart';
import 'package:attendance_app/Screens/loading.dart';
import 'package:attendance_app/Screens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthServices _auth = new AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }
  @override
  Widget build(BuildContext context) {
    return loading ? Loading("Signing out...") : Scaffold(
      appBar: AppBar(
        title: Text("Attendance App",),
        actions: [
          TextButton(
            onPressed: () async {
              await _auth.signOutGoogle();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
                (route) => false);
            },
            child: Text('LOGOUT'),
          ),
        ],
      ),
    );
  }
}
