import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Screens/home.dart';

import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool counter = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(themeColor == "white"){
      counter = false;
    }else{
      counter = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgCardColor,
          title: Text(
            'Settings',
            style: TextStyle(
              color:textColor,
              fontFamily: "Medium",
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: iconColor,),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>Home())
              );
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: bgColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 10.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: bgCardColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          activeColor: Colors.purple,
                          contentPadding: const EdgeInsets.fromLTRB(14, 5, 14, 5),
                          value: counter,
                          title: Text(
                            "Dark Theme",
                            style: TextStyle(
                              fontFamily: "Medium",
                              color: textColor,
                              fontSize: 18.0
                            )
                          ),
                          onChanged: (val) async {
                            setState(()=> counter = !counter);
                            if(counter == true){
                              setState(() => themeColor = "dark");
                              appTheme("dark");
                              await changeTheme("dark");
                            }else{
                              setState(() => themeColor = "white");
                              appTheme("white");
                              await changeTheme("white");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
