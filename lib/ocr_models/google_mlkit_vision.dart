import 'dart:io';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class GoogleMLKit {
  String _resultText = '';
  String _result = '';

  Future<String> readText(String imagePath) async {

    final _file = File(imagePath);
    _file.readAsBytesSync();

    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(_file);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          _resultText = _resultText + word.text + ' ';
        }
        // 마지막에 줄바꿈 추가
        _resultText = _resultText + '\n';
      }
    }

    textRecognizer.close();

    RegExp re = RegExp(r'(\d){2,9}');

    if (_resultText != null) {
      Iterable matches = re.allMatches(_resultText);
      matches.forEach((element) {
        _result = _result + _resultText.substring(
            element.start, element.end) + ' ';
      });
    }
    else {
      _result = 'No data';
    }

    return _result;
  }
}
