import 'dart:async';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

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
                TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue)),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('1.', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('사용 기술',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   ${_ocrModel.list[_ocrModel.currentNum]}'),
                            ]),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('2.', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 10),
                              Text('번호판 사진 촬영 결과',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 원본 사진 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                            ]),
                        SizedBox(height: 10),
                        SizedBox(height: 150, width: 300,
                            child: Image.file(File(_ocrModel.srcImagePath))),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 분석 대상 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(height: 30, width: 60,
                                  child: Image.file(File(_ocrModel.ocrImagePath))),
                            ]),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('3.', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('번호판 정보',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 인식 결과 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_ocrModel.ocrText}'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 응답 시간 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_ocrModel.responseTime/1000} sec'
                                  // '\n =${_ocrModel.endTime} \n - ${_ocrModel.startTime}'
                              ),
                            ]),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('4.', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('휴대전화 정보',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                            ]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 전화번호 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text(
                                  '+${_mobileInfo.phoneNumber.substring(0, 2)}'
                                      '-${_mobileInfo.phoneNumber.substring(2, 5)}'
                                      '-${_mobileInfo.phoneNumber.substring(5, 9)}'
                                      '-${_mobileInfo.phoneNumber.substring(9, 13)}'
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 통신회사 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.carrierName} (${_mobileInfo.mobileNetworkCode})'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 국가코드 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.isoCountryCode} (${_mobileInfo.mobileCountryCode})'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 제조회사 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.makerName}'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 모델이름 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.makerModelName}'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('   - 위치정보',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('     · 위도 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.locationLatitude}'),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('     · 경도 : ', style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1),
                              SizedBox(width: 5),
                              Text('${_mobileInfo.locationLongitude}'),
                            ]),

                        SizedBox(height: 15),

                        Center(
                            child: Text('${_loginInfo.name}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlue,
                                    fontStyle: FontStyle.italic)))
                      ]))));
    } else if (Platform.isIOS) {
      // iOS 코드 개발은 PoC 범위에서 제외.
    }
  }
}
