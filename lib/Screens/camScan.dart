import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/home.dart';
import 'package:marku/Screens/confirmAttendance.dart';
import 'package:marku/main.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class CamScan extends StatefulWidget {
  final List id ;
  final String branch;
  final String subject;
  final List presentId;
  CamScan(this.id, this.branch, this.subject,this.presentId);

  @override
  _CamScanState createState() => _CamScanState();
}


class _CamScanState extends State<CamScan> {

  late CameraController _controller;
  late Timer timer;
  late File imageFile;
  bool _load = false;
  bool tick = false;
  bool cross = false;
  // static const twoSec = Duration(seconds: 2);

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
      for (TextLine line in block.lines) {
        // Checking if the line contains an email address
        // print(line.text.toString());
        if (line.text.toString().contains("No.:")) {
          List idno = line.text.toString().split(" ");
          if (widget.id.contains(idno[idno.length-1])){
            if(!widget.presentId.contains(idno[idno.length - 1])){
              widget.presentId.add(idno[idno.length - 1]);
            }
            id = idno[idno.length - 1];
            break;
          }
          else{
            id="0";
            // print("Student does not exist");
            break;
          }
        }
      }
    }

    return id;
  }

  Future<String> _takePicture() async {

    // Checking whether the controller is initialized
    if (!_controller.value.isInitialized) {
      // print("Controller is not initialized");
      return "Camera controller not initialized";
    }

    // Formatting Date and Time
    // String dateTime = DateFormat.yMMMd()
    //     .addPattern('-')
    //     .add_Hms()
    //     .format(DateTime.now())
    //     .toString();

    // String formattedDateTime = dateTime.replaceAll(' ', '');
    // print("Formatted: $formattedDateTime");

    // Retrieving the path for saving an image
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String visionDir = '${appDocDir.path}/Photos/VisionImages';
    await Directory(visionDir).create(recursive: true);
    // final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

    // Checking whether the picture is being taken
    // to prevent execution of the function again
    // if previous execution has not ended
    if (_controller.value.isTakingPicture) {
      // print("Processing is in progress...");
      return "Processing img...";
    }

    try {
      // Captures the image and saves it to the
      // provided path
      final image = await _controller.takePicture();
      return image.path;
    } on CameraException catch (e) {
      // print("Camera Exception: $e");
      return e.toString();
    }
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
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => trial());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  trial() async{
    setState(()=> tick = false);
    // print("Reached Timer");
    setState(()=> _load = true);
    await _takePicture().then((String path) async  {
      // print("Taken Picture");
      if (path != null) {
        // print("Clicked");
        // String studentId = await scan(path);
        String studentId = await getText(path);
        // print("Student id: ${studentId}");
        setState(()=> _load = false);

        if(studentId != "" && studentId == "0"){
          // put cross sign
          setState(()=> cross = true);
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              cross = false;
            });
          });
        }else if(studentId != "" && studentId.length != 9){
          ScaffoldMessenger.of(context).showSnackBar(snackBar("Couldn\'t scan the ID, Try Again.", false));
        }
        else if(studentId != "" && studentId.length == 9){
          setState(()=> tick = true);
          Future.delayed(const Duration(seconds: 1), () {
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
                        _controller.dispose();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => const Home()),
                              (route) => false);
                        // Navigator.pop(context);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.red,
                        ),
                        child: const Icon(Icons.clear, color: Colors.white, size: 40,),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        timer.cancel();
                        _controller.dispose();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAttendance(widget.presentId, widget.branch, widget.subject,widget.id)));
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