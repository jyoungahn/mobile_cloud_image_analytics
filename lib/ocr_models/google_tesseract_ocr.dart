import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mobile_cloud_image_analytics/data/tesseract_ocr_json_parser.dart';
import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';
import 'dart:convert';

class TesseractOcr {
  String _resultText = '';

  Future<String> readText(String imagePath) async {

    // tesseract-ocr 4.0.0
    // String url = 'http://sfmi-vision-ocr40.koreacentral.azurecontainer.io:5000/';

    // tesseract-ocr 4.1.1
    String url = 'http://sfmi-vision-ocr.koreacentral.azurecontainer.io:5000/';

    try {
      // List<int> image = File(imagePath).readAsBytesSync();
      String image = base64Encode(File(imagePath).readAsBytesSync());

      Response response = await post(
        url,
        // headers: <String, String> { 'Content-Type': 'application/json' },
        headers: { "Accept": "application/json", "Content-type": "multipart/form-data" },
        body: jsonEncode({ 'image': '$image' }),
      );

      if (response.statusCode == 200) {
        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('response.body ▶▶▶ ' + response.body);
        print('--------------------------------------------------------------');

        Map<String, dynamic> jsonText = jsonDecode(response.body);
        TesseractOcrJsonParser tesseractOcrParser = TesseractOcrJsonParser.fromJson(jsonText);

        _resultText = tesseractOcrParser.text[0];

        tesseractOcrParser.text.forEach((element) {_resultText += element;});

        _resultText = getCarPlateNumber(_resultText);
      }
      else {
        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('response.statusCode ▶▶▶ ' + response.statusCode.toString());
        print('response.body ▶▶▶ ' + response.body);
        print('--------------------------------------------------------------');
      }
    }
    catch (e) {
      // TODO: This debugging code should be deleted.
      print('--------------------------------------------------------------');
      print('Tesseract Azure API Exception ▶▶▶' + e.toString());
      print('--------------------------------------------------------------');
    }

    return _resultText;
  }
}