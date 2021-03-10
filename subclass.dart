import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class subclass extends StatefulWidget {
  @override
  _subclassState createState() => _subclassState();
}

class _subclassState extends State<subclass> {
  final database = FirebaseFirestore.instance;
  Widget TopBar() {
    return SafeArea(
      child: Container(
        height: 55.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              onPressed: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0,0.0,10,0.0),
              child: Center(
                  child: Text('Class Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
              ),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              iconSize: 30,
              padding: EdgeInsets.fromLTRB(0.0,0.0,30,0.0),
              onPressed: () => Navigator.of(context).pop(
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TopBar(),
                SizedBox(height: 10),
                Text('SE Comps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,fontFamily: "Bold")),
                SizedBox(height: 10),
                Text('Subject', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Regular")),
                Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                        .collection('comps')
                                        .doc('year2')
                                        .collection('students')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                    return Text('Error in Connection ${snapshot.error}');
                                    }
                                    switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                        return Center(
                                        child: Text('Connecting'),
                                        );
                                        case ConnectionState.none:
                                        return Text('No Data Available');

                                        case ConnectionState.done:
                                        return Text('Connection State Done');

                                        default:
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 6.0, vertical: 10.0),
                                          child: ListView.separated(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              separatorBuilder: (BuildContext context, int index) => Divider(height: 50),
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data.docs.length,
                                              itemBuilder: (BuildContext context, index){
                                                DocumentSnapshot studentlist = snapshot.data.docs[index];
                                                return Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(20.0,0.0,10,0.0),
                                                              child: Text(studentlist.data()['name'],style: TextStyle(fontFamily: "Bold", fontSize: 20.0,),),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.fromLTRB(50.0,0.0,10,0.0),
                                                              child: Text(studentlist.data()['id'],style: TextStyle(fontFamily: "Regular", fontSize: 20.0,),),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                                // return Card(
                                                //   margin: EdgeInsets.all(10),
                                                //   child: Padding(
                                                //     padding: const EdgeInsets.all(10.0),
                                                //     child: Column(
                                                //       children: [
                                                //         Text(studentlist.data()['id']+' - '+studentlist.data()['name']),
                                                //         Text(studentlist.data()['phone']+' - '+studentlist.data()['year'].toString()),
                                                //
                                                //       ],
                                                //     ),
                                                //   ),
                                                // );
                                              }
                                          ),
                                        );
                                    } //switch case
                                } // builder
                          ),
                      ],
                    ),



              ],
            ),

      )
    );
  }
}