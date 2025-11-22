import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection_app_by_flutter/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isWorking = false;
  String result = "";
  CameraController? cameraController;
  CameraImage? imgCamera;
  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
      cameraController!.startImageStream((imageFromStream) {
        if (!isWorking) {
          isWorking = true;
          imgCamera = imageFromStream;
          // runModelOnFrame();
        }
      });
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg3.jpg"),
                fit: BoxFit.cover,
              ),
              // color: Colors.black,
              // borderRadius: BorderRadius.circular(12),
            ),
            // margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 320,
                    width: 330,
                    child: Image.asset("assets/bg1.jpg"),
                  ),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      initCamera();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 35),
                      height: 270,
                      width: 360,
                      child: imgCamera == null
                          ? Container(
                              height: 270,
                              width: 360,
                              child: Icon(
                                Icons.photo_camera_front,
                                size: 40,
                                color: Colors.blueAccent,
                              ),
                            )
                          : (cameraController != null &&
                                cameraController!.value.isInitialized)
                          ? AspectRatio(
                              aspectRatio: cameraController!.value.aspectRatio,
                              child: CameraPreview(cameraController!),
                            )
                          : Container(
                              height: 270,
                              width: 360,
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
