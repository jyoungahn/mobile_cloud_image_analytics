import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_result.dart';
import 'package:camera/camera.dart';

class DemoCameraControlPage extends StatefulWidget {
  @override
  _DemoCameraControlPage createState() => _DemoCameraControlPage();
}

class _DemoCameraControlPage extends State<DemoCameraControlPage> {
  OcrModel _ocrModel;
  List _cameras;
  CameraDescription _currentCamera;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  @override
  void initState() {
    super.initState();
    availableCameras().then((availableCameras) {
      _cameras = availableCameras;
      _currentCamera = _cameras.first;
      _cameraController = CameraController(_currentCamera, ResolutionPreset.medium);
      _initializeCameraControllerFuture = _cameraController.initialize();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get OcrModel from Provider.
    _ocrModel = Provider.of<OcrModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('번호판 촬영',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(132, 215, 233, 0.5)),
                  child: Center(
                    child: Text(
                      '자동차 번호판을 촬영합니다.\n\n'
                          '1. 번호판을 아래 창에 잘 맞춰 주세요.\n'
                          '2. 사진 찍기 버튼을 줄러 주세요.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(132, 215, 233, 0.5)),
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(132, 215, 233, 0.5)),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(132, 215, 233, 0.5)),
                  child: Center(
                    child: Text(
                      '※ 주의 사항\n\n'
                          ' - 네모상자에 초점을 맞춰 주세요.\n'
                          ' - 빛이 반사되지 않도록 방향을 조정해 주세요.',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                flex: 5,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try {
            await _initializeCameraControllerFuture;
            _ocrModel.imagePath = join(
              (await getTemporaryDirectory()).path,
              'SFMI_Vision_CarPlate_${DateTime.now()}.png',
            );
            await _cameraController.takePicture(_ocrModel.imagePath);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DemoResultPage(),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

// Show error message.
// Future<void> showCameraErrorDialog() async {
//   return showDialog<void>(
//     // context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Center(
//             child: Text(
//               '번호판 인식 오류',
//               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//             )),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('번호판이 인식되지 않았습니다.\n다시 촬영해 주시기 바랍니다.', style: TextStyle(fontSize: 16)),
//               Text('※ 중앙 네모상자에 번호판을 잘 맞춰 주세요.', style: TextStyle(fontSize: 16)),
//               Text('※ 빛이 반사되지 않도록 방향을 조정해 주세요.', style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('확인'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
}