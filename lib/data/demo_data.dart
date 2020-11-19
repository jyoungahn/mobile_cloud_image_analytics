import 'package:flutter/material.dart';

class LoginInfo extends ChangeNotifier {
  String id;
  String name;
}

class OcrModel extends ChangeNotifier {
  // Current OCR model number[0-5].
  int currentNum;
  final List<String> list = [
    '① Flutter + Azure OCR (상용)',
    '② Flutter + Google OCR (상용)',
    '③ Flutter + Tesseract-OCR (오픈소스)',
    '④ Flutter + Google ML Kit (오픈소스)',
    '⑤ Flutter + TensorFlow (자체개발)',
    '⑥ Flutter + TF Lite (자체개발)',
  ];
  String srcImagePath;
  String ocrImagePath;
  String ocrText;
  DateTime startTime;
  DateTime endTime;
  var responseTime;
}

class MobileInfo extends ChangeNotifier {
  String phoneNumber; // 전화번호
  String carrierName; // 통신사
  String mobileNetworkCode; // 모바일 네트워크 코드
  String isoCountryCode; // ISO 국가 코드(예: kr)
  String mobileCountryCode; // 국가 코드(숫자)
  String makerName; // 제조사
  String makerModelName; // 제조사 모델명
  String makerModelNumber; // 모델번호

  double locationLatitude; // 위치정보 : 위도
  double locationLongitude; // 위치정보 : 경도
}
