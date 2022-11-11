import 'package:marku/Authentication/auth.dart';
import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Screens/loading.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthServices _auth = new AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading("Signing In...") : Scaffold(
      body: SingleChildScrollView(
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
                SizedBox(height: 15.0,),
                Text(
                    'The Ultimate attendance app',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: "Bold",
                    )
                ),
                SizedBox(height: 50.0,),
                Text(
                    'Let\'s get started',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "Medium",
                    )
                ),
                SizedBox(height: 100.0,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,

                  child: ElevatedButton(
                      onPressed: () async {
                        await _auth.signInWithGoogle().then((value) async {
                          if(value != null){
                            await getTeacher();
                            appTheme(themeColor);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Home()),
                                  (Route<dynamic> route) => false,
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0.0),
                        primary: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        textStyle: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                          fontFamily: "Bold",
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[Color(0xFF3a5af9), Color(0xFF7449fa)]),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 18, fontFamily: "Bold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                  ),
                ),
                // child: RaisedButton(
                //     onPressed: (){
                //
                //     },
                //     textColor: Color(0xFFFFFFFF),
                //     elevation: 4,
                //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                //     padding: const EdgeInsets.all(0.0),
                //     child: Container(
                //       decoration: const BoxDecoration(
                //         gradient: LinearGradient(colors: <Color>[Color(0xFF3a5af9), Color(0xFF7449fa)]),
                //         borderRadius: BorderRadius.all(Radius.circular(80.0)),
                //       ),
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                //           child: Text(
                //             "Sign In",
                //             style: TextStyle(fontSize: 18, fontFamily: "Bold"),
                //             textAlign: TextAlign.center,
                //           ),
                //         ),
                //       ),
                //

              ],
            ),
          ),
        ),
      ),
    );
  }
}