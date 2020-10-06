import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class DemoResultPage extends StatefulWidget {
  @override
  _DemoResultPageState createState() => _DemoResultPageState();
}

class _DemoResultPageState extends State<DemoResultPage> {
  LoginInfo _loginInfo;
  OcrModel _ocrModel;
  MobileInfo _mobileInfo;

  @override
  Widget build(BuildContext context) {
    _loginInfo = Provider.of<LoginInfo>(context, listen: false);
    _ocrModel = Provider.of<OcrModel>(context, listen: false);
    _mobileInfo = Provider.of<MobileInfo>(context, listen: false);

    if (Platform.isAndroid) {
      return Scaffold(
          appBar: AppBar(
            title: Text('번호판 인식 결과',
                style:
                TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
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
                        SizedBox(height: 20),
                        Text('OCR Model Number: ${_ocrModel.currentNum}'),
                        Text('OCR Model Description: ${_ocrModel.list[_ocrModel.currentNum]}'),
                        Text('MobileInfo - phoneNumber: ${_mobileInfo.phoneNumber}'),
                        Text('MobileInfo - carrierName: ${_mobileInfo.carrierName}'),
                        Text('MobileInfo - mobileNetworkCode: ${_mobileInfo.mobileNetworkCode}'),
                        Text('MobileInfo - isoCountryCode: ${_mobileInfo.isoCountryCode}'),
                        Text('MobileInfo - mobileCountryCode: ${_mobileInfo.mobileCountryCode}'),
                        Text('MobileInfo - makerName: ${_mobileInfo.makerName}'),
                        Text('MobileInfo - makerModelName: ${_mobileInfo.makerModelName}'),
                        Text('MobileInfo - makerModelNumber: ${_mobileInfo.makerModelNumber}'),
                        // Text('MobileInfo - SerialNumber: ${_mobileInfo.makerSerialNumber}'),
                        // Text('MobileInfo - MacAddress: ${_mobileInfo.macAddress}'),
                        // Text('MobileInfo - imeiNumber: ${_mobileInfo.imeiNumber}'),
                        Text('LoginInfo - id: ${_loginInfo.id}'),
                        Text('LoginInfo - name: ${_loginInfo.name}'),
                        Center(
                            child: Text(_loginInfo.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlue,
                                    fontStyle: FontStyle.italic)))
                      ]))));
    } else if (Platform.isIOS) {
      // iOS 코드 개발은 PoC 범위에서 제외함.
    }

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
                      SizedBox(height: 20),
                      Center(
                          child: Text(_loginInfo.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.lightBlue,
                                  fontStyle: FontStyle.italic)))
                    ]))));
  }
}
