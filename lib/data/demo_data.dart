import 'package:flutter/material.dart';

class LoginInfo extends ChangeNotifier {
  String id;
  String name;
}

class OcrModel extends ChangeNotifier {
  // Current OCR model number[0-5].
  int currentNum;
  final List<String> list = [
    '① Flutter + Tesseract-OCR',
    '② Flutter + Azure OCR',
    '③ Flutter + Google OCR',
    '④ Flutter + TensorFlow',
    '⑤ Flutter + TF Lite',
    '⑥ Flutter + Google ML Kit',
  ];
  String imagePath;
  String ocrText;
  String responseTime;
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

  String locationLatitude; // 위치정보 : 위도
  String locationLongitude; // 위치정보 : 경도
}
