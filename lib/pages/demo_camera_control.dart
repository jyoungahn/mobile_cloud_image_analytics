import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_result.dart';

class DemoCameraControlPage extends StatefulWidget {
  @override
  _DemoCameraControlPage createState() => _DemoCameraControlPage();
}

class _DemoCameraControlPage extends State<DemoCameraControlPage> {
  OcrModel _ocrModel;
  LoginInfo _loginInfo;
  MobileInfo _mobileInfo;

  @override
  Widget build(BuildContext context) {
    // Get LoginInfo from Provider.
    _loginInfo = Provider.of<LoginInfo>(context, listen: false);
    _ocrModel = Provider.of<OcrModel>(context, listen: false);
    _mobileInfo = Provider.of<MobileInfo>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('번호판 사진 촬영',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey,
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                height: 54.0,
                padding: EdgeInsets.all(12.0),
                child:
                Text('사진 촬영 기능 재개발 중', style: TextStyle(fontWeight: FontWeight.w700))),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child:
              Text('결과 화면으로 이동', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DemoResultPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

/// Show error message.
// Future<void> showCameraErrorAlertDialog() async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Center(
//             child: Text(
//           '번호판 인식 오류',
//           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//         )),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('1. 번호판을 기준선에 맞춰 주세요.', style: TextStyle(fontSize: 16)),
//               Text('2. 초점을 중앙에 맞춰 주세요.', style: TextStyle(fontSize: 16)),
//               Text('3. 빛 반사에 주의해 주세요.', style: TextStyle(fontSize: 16)),
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
