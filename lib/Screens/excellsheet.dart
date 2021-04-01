import 'dart:io';
import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Alignment;

import '../Helpers/save_file_mobile.dart';

void main() {
  runApp(CreateExcelWidget());
}

/// Represents the XlsIO widget class.
class CreateExcelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateExcelStatefulWidget(title: 'Create Excel document'),
    );
  }
}

/// Represents the XlsIO stateful widget class.
class CreateExcelStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreateExcelStatefulWidget] class.
  const CreateExcelStatefulWidget({Key key, this.title}) : super(key: key);

  /// title.
  final String title;
  @override
  _CreateExcelState createState() => _CreateExcelState();
}

class _CreateExcelState extends State<CreateExcelStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: const Text('Generate Excel'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.lightBlue,
                onSurface: Colors.grey,
              ),
              //onPressed: generateExcel,
            )
          ],
        ),
      ),
    );
  }
}





