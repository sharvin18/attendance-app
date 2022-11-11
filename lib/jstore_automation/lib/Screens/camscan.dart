<<<<<<< HEAD
import 'dart:async';
import 'dart:io';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:attendance_app/Screens/confirm_attendance.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
=======
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/confirm_attendance.dart';
import 'package:marku/main.dart';
import 'package:marku/Screens/subclass.dart';
// import 'package:marku/Helpers/text_recognizer.dart';
// import 'package:marku/model/data_layer.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:camera/camera.dart';
>>>>>>> version-upgrade
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
<<<<<<< HEAD
import '../main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'subclass.dart';
=======
import 'dart:async';
import 'dart:io';
>>>>>>> version-upgrade

class Camscan extends StatefulWidget {
  final List id ;
  final String branch;
  final String subject;
  final List present_id;
  Camscan(this.id, this.branch, this.subject,this.present_id);

  @override
  _CamscanState createState() => _CamscanState();
}


class _CamscanState extends State<Camscan> {

<<<<<<< HEAD
  CameraController _controller;
  Timer timer;
  File imageFile;
  bool _load = false;
  bool tick = false;
  static const twoSec = const Duration(seconds: 2);

  Future<String> scan(String imgpath) async{
    final File imageFile = File(imgpath);

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();

    final VisionText visionText = await textRecognizer.processImage(visionImage);

    String id = "";

    for (TextBlock block in visionText.blocks) {
=======
  late CameraController _controller;
  late Timer timer;
  late File imageFile;
  bool _load = false;
  bool tick = false;
  bool cross = false;
  static const twoSec = Duration(seconds: 2);

  Future<String> getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    // final inputImage = Image.file(File(path));
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognisedText =
    await textDetector.processImage(inputImage);

    // List<RecognizedText> recognizedList = [];
    List<String> predictions = [];

    for (TextBlock block in recognisedText.blocks) {
      // recognizedList.add(
      //     RecognizedText(text: block.lines, blocks: block.text.toLowerCase()));
      predictions.add(block.text.toLowerCase());
    }

    String id = "";

    for (TextBlock block in recognisedText.blocks) {
>>>>>>> version-upgrade
      for (TextLine line in block.lines) {
        // Checking if the line contains an email address
        print(line.text.toString());
        if (line.text.toString().contains("No.:")) {
          List idno = line.text.toString().split(" ");
          if (widget.id.contains(idno[idno.length-1])){
            if(!widget.present_id.contains(idno[idno.length - 1])){
              widget.present_id.add(idno[idno.length - 1]);
            }
            id = idno[idno.length - 1];
            break;
          }
          else{
<<<<<<< HEAD
=======
            id="0";
>>>>>>> version-upgrade
            print("Student does not exist");
            break;
          }
        }
      }
    }
<<<<<<< HEAD
    return id;
  }

=======

    // return recognizedList;
    return id;
  }

  // Future<String> scan(String imgpath) async{
  //
  //   final File imageFile = File(imgpath);
  //   final InputImage inputImage = InputImage.fromFile(imageFile);
  //
  //   final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  //
  //   final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);
  //
  //   final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
  //
  //   final VisionText visionText = await textRecognizer.processImage(visionImage);
  //
  //   String id = "";
  //
  //   for (TextBlock block in visionText.blocks) {
  //     for (TextLine line in block.lines) {
  //       // Checking if the line contains an email address
  //       print(line.text.toString());
  //       if (line.text.toString().contains("No.:")) {
  //         List idno = line.text.toString().split(" ");
  //         if (widget.id.contains(idno[idno.length-1])){
  //           if(!widget.present_id.contains(idno[idno.length - 1])){
  //             widget.present_id.add(idno[idno.length - 1]);
  //           }
  //           id = idno[idno.length - 1];
  //           break;
  //         }
  //         else{
  //           id="0";
  //           print("Student does not exist");
  //           break;
  //         }
  //       }
  //     }
  //   }
  //   return id;
  // }

>>>>>>> version-upgrade
  Future<String> _takePicture() async {

    // Checking whether the controller is initialized
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
<<<<<<< HEAD
      return null;
=======
      return "Camera controller not initialized";
>>>>>>> version-upgrade
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
<<<<<<< HEAD
    final String visionDir = '${appDocDir.path}/Photos/Vision\ Images';
=======
    final String visionDir = '${appDocDir.path}/Photos/VisionImages';
>>>>>>> version-upgrade
    await Directory(visionDir).create(recursive: true);
    final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

    // Checking whether the picture is being taken
    // to prevent execution of the function again
    // if previous execution has not ended
    if (_controller.value.isTakingPicture) {
      print("Processing is in progress...");
<<<<<<< HEAD
      return null;
=======
      return "Processing img...";
>>>>>>> version-upgrade
    }

    try {
      // Captures the image and saves it to the
      // provided path
<<<<<<< HEAD
      await _controller.takePicture(imagePath);
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }

    return imagePath;
=======
      final image = await _controller.takePicture();
      return image.path;
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return e.toString();
    }

    return "no image";
>>>>>>> version-upgrade
  }


  @override
  void initState() {
    super.initState();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
<<<<<<< HEAD
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => trial());
=======
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => trial());
>>>>>>> version-upgrade
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  trial() async{
    setState(()=> tick = false);
    print("Reached Timer");
    setState(()=> _load = true);
    await _takePicture().then((String path) async  {
      print("Taken Picture");
      if (path != null) {
        print("Clicked");
<<<<<<< HEAD
        String student_id = await scan(path);
        print("Student id: ${student_id}");
        setState(()=> _load = false);

        if(student_id.length != 9 && student_id != ""){
          ScaffoldMessenger.of(context).showSnackBar(snackBar("Couldn\'t scan the ID, Try Again.", false));
        }
        else if(student_id.length == 9 && student_id != ""){
          setState(()=> tick = true);
          new Future.delayed(new Duration(seconds: 1), () {
=======
        // String student_id = await scan(path);
        String student_id = await getText(path);
        print("Student id: ${student_id}");
        setState(()=> _load = false);

        if(student_id != "" && student_id == "0"){
          // put cross sign
          setState(()=> cross = true);
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              cross = false;
            });
          });
        }else if(student_id != "" && student_id.length != 9){
          ScaffoldMessenger.of(context).showSnackBar(snackBar("Couldn\'t scan the ID, Try Again.", false));
        }
        else if(student_id != "" && student_id.length == 9){
          setState(()=> tick = true);
          Future.delayed(const Duration(seconds: 1), () {
>>>>>>> version-upgrade
            setState(() {
              tick = false;
            });
          });
        }
      }else{
        setState(()=> _load = false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar("Couldn\'t scan the ID, Try Again.", false));
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: _controller.value.isInitialized
          ? Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              height: height * 0.18,
              width: width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        timer.cancel();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SubClass(widget.branch, widget.subject)),
                            (route) => false);
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
                      onTap: (){
                        timer.cancel();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAttendance(widget.present_id, widget.branch, widget.subject,widget.id)));
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
          _load ? Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: Center(
              child: SpinKitFadingCircle(
                color: Colors.blue[600],
                size: 60.0,
              ),
            ),
          ) : Container(),
          tick ? Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
<<<<<<< HEAD
                child: Icon(Icons.done_sharp, color: Colors.white, size: 20,),
=======
                child: const Icon(Icons.done_sharp, color: Colors.white, size: 20,),
              ),
            ),
          ): cross? Container(
            height: height,
            width: width,
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                ),
                child: Icon(Icons.highlight_remove_sharp, color: Colors.white, size: 20,),
>>>>>>> version-upgrade
              ),
            ),
          ) : Container()
        ],
      )
          : Container(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}