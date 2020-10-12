import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_camera_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

class DemoStartPage extends StatefulWidget {
  @override
  _DemoStartPage createState() => _DemoStartPage();
}

class _DemoStartPage extends State<DemoStartPage> {
  LoginInfo _loginInfo;
  OcrModel _ocrModel;

  List<CameraDescription> _cameras;
  CameraDescription _camera;

  @override
  void initState() {
    super.initState();
    // Set the device camera.
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((availableCameras) {
      _cameras = availableCameras;
      _camera = _cameras.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get LoginInfo and OcrModel from Provider.
    _loginInfo = Provider.of<LoginInfo>(context, listen: false);
    _ocrModel = Provider.of<OcrModel>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Text('이미지분석 기술 선택',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
          backgroundColor: Colors.white,
          shadowColor: Colors.grey,
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1.', style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(width: 10),
                              Text('사진 촬영이 가능한 자동차의 앞 또는 뒤 \n번호판을 찍습니다.',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ]),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2.', style: Theme.of(context).textTheme.bodyText1),
                            SizedBox(width: 10),
                            Text('검증할 기술을 선택하세요. (아래 버튼 선택)',
                                style: Theme.of(context).textTheme.bodyText1),
                          ]),
                      SizedBox(height: 20),
                      RaisedButton(
                        child: Text(_ocrModel.list[0],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(0),
                      ),
                      SizedBox(height: 1),
                      RaisedButton(
                        child: Text(_ocrModel.list[1],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(1),
                      ),
                      SizedBox(height: 1),
                      RaisedButton(
                        child: Text(_ocrModel.list[2],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(2),
                      ),
                      SizedBox(height: 1),
                      RaisedButton(
                        child: Text(_ocrModel.list[3],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(3),
                      ),
                      SizedBox(height: 1),
                      RaisedButton(
                        child: Text(_ocrModel.list[4],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(4),
                      ),
                      SizedBox(height: 1),
                      RaisedButton(
                        child: Text(_ocrModel.list[5],
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        onPressed: () => move2TargetPage(5),
                      ),
                      SizedBox(height: 20),
                      Center(
                          child: Text(_loginInfo.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightBlue,
                                  fontStyle: FontStyle.italic)))
                    ]))));
  }

  void move2TargetPage(int ocrNum) {
    _ocrModel.currentNum = ocrNum;
    Navigator.push(context, MaterialPageRoute(builder: (context) => DemoCameraControlPage(camera: _camera,)));
  }
}
