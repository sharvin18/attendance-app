import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/utils.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/home.dart';
import 'package:marku/Screens/confirmAttendance.dart';
import 'package:marku/Screens/loading.dart';
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
  final List<List> presentId;
  const CamScan(this.presentId);

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
  bool isDev = true;
  late List<List> invalidIds = [];
  var displayDate;
  var storeDate;
  bool _loading = false;

  Future<bool> saveId(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    // final inputImage = Image.file(File(path));
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognisedText =
    await textDetector.processImage(inputImage);

    // List<RecognizedText> recognizedList = [];
    List<String> predictions = [];

    // Predictions list is not being used anywhere
    for (TextBlock block in recognisedText.blocks) {
      // recognizedList.add(
      //     RecognizedText(text: block.lines, blocks: block.text.toLowerCase()));
      predictions.add(block.text.toLowerCase());
    }

    String id = "";

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        if(isDev) print(line.text.toString());

        // Logic for client
        // if(line.text.toString().contains(",") && line.text.toString().length==20){
        //   if (!widget.presentId.contains(line.text.toString())){
        //     widget.presentId.add(line.text.toString());
        //     return true;
        //   }
        // }

        // Logic for clg Deployment
        if (line.text.toString().contains("No.:")) {
          List idno = line.text.toString().split(" ");
          if (isDev) print(idno[idno.length - 1]);
          if(!widget.presentId.contains(idno[idno.length - 1])){
            List temp = [];
            DateTime currTime = DateTime.now();
            temp.add(idno[idno.length - 1]);
            temp.add(currTime);
            widget.presentId.add(temp);
          }
          return true;
        }
      }
    }

    return false;
  }

  Future<String> _takePicture() async {

    // Checking whether the controller is initialized
    if (!_controller.value.isInitialized) {
      return "Camera controller not initialized";
    }

    // Retrieving the path for saving an image
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String visionDir = '${appDocDir.path}/Photos/VisionImages';
    await Directory(visionDir).create(recursive: true);
    // final String imagePath = '$visionDir/image_$formattedDateTime.jpg';

    if (_controller.value.isTakingPicture) {
      // print("Processing is in progress...");
      return "Processing img...";
    }

    try {
      final image = await _controller.takePicture();
      return image.path;
    } on CameraException catch (e) {
      if(isDev) print("Camera Exception: $e");
      return e.toString();
    }
  }


  @override
  void initState() {
    super.initState();
    storeDate = getTodaysDate();
    displayDate = formatDateDMY(storeDate);
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) => scan());
  }

  @override
  void dispose() {
    _controller.dispose();
    // timer.cancel();
    super.dispose();
  }

  scan() async{
    setState(()=> tick = false);
    setState(()=> _load = true);

    await _takePicture().then((String path) async  {

      if (path != null) {

        if(isDev) print("Picture captured");

        bool studentIdIsSaved = await saveId(path);
        if(isDev) print("studentIdIsSaved: " + studentIdIsSaved.toString());
        setState(()=> _load = false);

        if(!studentIdIsSaved){
          // put cross sign
          setState(()=> cross = true);
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              cross = false;
            });
          });
        }else {
          setState(()=> tick = true);
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              tick = false;
            });
          });
        }
      }else{
        if(isDev) print("Some error occured while capturing the image");
        setState(()=> _load = false);
        ScaffoldMessenger.of(context).showSnackBar(snackBar("Couldn\'t scan the ID, Try Again.", false));
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: _loading == true? Loading("Organizing data") : _controller.value.isInitialized
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
                        // _controller.dispose();
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
                      onTap: () async {
                        timer.cancel();
                        // _controller.dispose();
                        setState(() {
                          _loading = true;
                        });
                        invalidIds = await getInvalidIds(widget.presentId, displayDate);
                        setState(() {
                          for(int i=0; i<invalidIds.length; i++){
                            widget.presentId.remove(invalidIds[i][0]);
                          }
                        });

                        List temp = [];
                        temp.add("191183101");
                        temp.add("Sharvin Dedhia");
                        invalidIds.add(temp);
                        // setState(() {
                        //   _loading = false;
                        // });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAttendance(widget.presentId, invalidIds)));
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