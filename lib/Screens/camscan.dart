import 'dart:io';
import 'package:attendance_app/Screens/confirm_attendance.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../main.dart';

class Camscan extends StatefulWidget {
  final List id ;
  final String branch;
  final String subject;
  Camscan(this.id, this.branch, this.subject);

  @override
  _CamscanState createState() => _CamscanState();
}

class _CamscanState extends State<Camscan> {
  CameraController _controller;
  File imageFile;
  List present_id;


  Future scan(String imgpath) async{
    final File imageFile = File(imgpath);

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

    final VisionText visionText = await textRecognizer.processImage(visionImage);

    //String pattern = r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)$";
    //String pattern2 = r".:";
    //RegExp regEx = RegExp(pattern);

    String id = "";

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        // Checking if the line contains an email address
        print(line.text.toString());
        if (line.text.toString().contains("No.:")) {
          List idno = line.text.toString().split(" ");
          if (widget.id.contains(idno[idno.length-1])){
            print(idno[idno.length - 1]);
            id += line.text;
            present_id.add(idno[idno.length - 1]);
            print(present_id.toString());

            break;
          }
          else{
            print("Student does not exist");
            break;
          }
        }
      }
    }
    print(id);
  }

  Future<String> _takePicture() async {

    // Checking whether the controller is initialized
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    // Formatting Date and Time
    String dateTime = DateFormat.yMMMd()
        .addPattern('-')
        .add_Hms()
        .format(DateTime.now())
        .toString();

    String formattedDateTime = dateTime.replaceAll(' ', '');
    print("Formatted: $formattedDateTime");

    // Retrieving the path for saving an image
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String visionDir = '${appDocDir.path}/Photos/Vision\ Images';
    await Directory(visionDir).create(recursive: true);
    final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

    // Checking whether the picture is being taken
    // to prevent execution of the function again
    // if previous execution has not ended
    if (_controller.value.isTakingPicture) {
      print("Processing is in progress...");
      return null;
    }

    try {
      // Captures the image and saves it to the
      // provided path
      await _controller.takePicture(imagePath);
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }

    return imagePath;
  }


  @override
  void initState() {
    super.initState();
    present_id = [];

    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red,
                        ),
                        child: Icon(Icons.clear, color: Colors.white, size: 40,),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _takePicture().then((String path) async  {
                          if (path != null) {
                            print("Clicked");
                            await scan(path) ;
                          }
                        });
                      },
                      child: Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.grey[300],
                        ),
                        child: Icon(Icons.camera, color: Colors.black,size: 50,),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAttendance(present_id, widget.branch, widget.subject)));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 35,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
          : Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

  }

}