import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/google_tesseract_ocr.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/google_cloud_vision.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/google_mlkit_vision.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/microsoft_azure_vision.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/sfmi_da_ocr_tensorflow.dart';
import 'package:mobile_cloud_image_analytics/ocr_models/sfmi_da_ocr_tensorflowlite.dart';
import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_result.dart';


class DemoCameraControlPage extends StatefulWidget {
  final CameraDescription camera;

  const DemoCameraControlPage({Key key, this.camera}) : super(key: key);

  @override
  _DemoCameraControlPage createState() => _DemoCameraControlPage();
}

class _DemoCameraControlPage extends State<DemoCameraControlPage> {
  OcrModel _ocrModel;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  bool _ocrOk = false;

  Future<bool> _executeOcr(String imagePath) async {
    String _ocrText = '';
    _ocrModel.startTime = DateTime.now();

    switch (_ocrModel.currentNum) {
      case 0 : // ① Flutter + Tesseract-OCR
        TesseractOcr tess = TesseractOcr();
        _ocrText = tess.readText(imagePath);
        break;
      case 1 : // ② Flutter + Azure OCR
        AzureVision azureVision = AzureVision();
        _ocrText = await azureVision.readText(imagePath);
        break;
      case 2: //③ Flutter + Google OCR
        GoogleCloudVision googleVision = GoogleCloudVision();
        _ocrText = await googleVision.readText(imagePath);
        break;
      case 3: // ④ Flutter + TensorFlow
        SfmiDaOcr sfmiDaOcr = SfmiDaOcr();
        _ocrText = sfmiDaOcr.readText(imagePath);
        break;
      case 4: // ⑤ Flutter + TF Lite
        SfmiDaOcrMobile sfmiDaOcrMobile = SfmiDaOcrMobile();
        _ocrText = sfmiDaOcrMobile.readText(imagePath);
        break;
      case 5: // ⑥ Flutter + Google ML Kit
        GoogleMLKit googleMLKit = GoogleMLKit();
        _ocrText = googleMLKit.readText(imagePath);
        break;
    }

    _ocrModel.endTime = DateTime.now();
    _ocrModel.ocrText = _ocrText;
    _ocrModel.responseTime = _ocrModel.endTime.difference(_ocrModel.startTime).inMilliseconds;

    if (_ocrText == '') {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get OcrModel from Provider.
    _ocrModel = Provider.of<OcrModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('번호판 촬영',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue)),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeCameraControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // return Container(
                //   child: AspectRatio(
                //     aspectRatio: _cameraController.value.aspectRatio,
                //     child: CameraPreview(_cameraController),
                //   ),
                // );

                return Container(
                  child: Transform.scale(
                    scale: 1 / _cameraController.value.aspectRatio,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _cameraController.value.aspectRatio,
                        child: CameraPreview(_cameraController),
                      ),
                    ),
                  ),
                );

                CameraPreview(_cameraController);
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
                      color: Color.fromRGBO(132, 215, 233, 0.8)),
                  child: Center(
                    child: Text(
                      '자동차 번호판을 촬영합니다.\n'
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
                              color: Color.fromRGBO(132, 215, 233, 0.8)),
                        ),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(),
                        flex: 2,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(132, 215, 233, 0.8)),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(132, 215, 233, 0.8)),
                  child: Center(
                    child: Text(
                      '※ 주의 사항\n'
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
              'SFMI_Vision_${DateTime.now()}.png',
            );
            await _cameraController.takePicture(_ocrModel.imagePath);

            // TODO: OCR 모델을 읽고 결과값을 저장하는 코드 추가
            _ocrOk = await _executeOcr(_ocrModel.imagePath);

            if (_ocrOk) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DemoResultPage(),
                ),
              );
            } else {
              // TODO: Error 메시지 화면 테스트를 위한 변수. Cloud-side 개발 후 반드시 삭제할 것.
              _ocrOk = true;
              return showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        '번호판 인식 오류',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold),
                      )
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('번호판이 인식되지 않았습니다.\n다시 촬영해 주시기 바랍니다.',
                            style: TextStyle(fontSize: 14)),
                          Text('\n - 네모상자에 번호판을 맞추세요.',
                            style: TextStyle(fontSize: 14)),
                          Text('\n - 빛이 반사되지 않게 방향을 조정하세요.',
                            style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text('확인'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
