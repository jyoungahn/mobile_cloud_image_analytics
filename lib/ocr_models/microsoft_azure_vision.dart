import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';
import 'package:mobile_cloud_image_analytics/data/azure_vision_json.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class AzureVision {
  String _resultText = '';

  Future<String> readText(String imagePath) async {
    String endpoint = 'https://koreacentral.api.cognitive.microsoft.com';
    String language = 'ko';
    String detectOrientation = 'false';
    String url = '$endpoint/vision/v2.0/ocr?language=$language'
        '&detectOrientation=$detectOrientation';
    String azureApiKey = '10836b08a9b94acdb129b0cbc6bdbffe';

    // TODO: This debugging code should be deleted.
    // start ▶▶▶ 카메라에서 찍은 사진 파일을 테스트용 '번호판_38육4104_cropped.png' 파일로 교체
/*
    print('[junyoung.ahn] ▶▶▶ ' + url);
    final byteData = await rootBundle.load('assets/images/번호판_38육4104_cropped.png');
    imagePath = (await getTemporaryDirectory()).path + '/번호판_38육4104_cropped.png';
    final file = File(imagePath);
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
*/
    // ◀◀◀ end

    try {
      Response response = await post(
        url,
        headers: <String, String>{
          "Content-Type": "application/octet-stream",
          "Ocp-Apim-Subscription-Key": "$azureApiKey",
        },
        body: File(imagePath).readAsBytesSync(),
      );

      if (response.statusCode == 200) {
        // TODO: This debugging code should be deleted.
        print('[junyoung.ahn] ▶▶▶ ' + response.body);

        Map<String, dynamic> jsonText = jsonDecode(response.body);
        AzureOcrJsonParser azureOcrParser = AzureOcrJsonParser.fromJson(jsonText);

        _resultText = azureOcrParser.regions[0].lines[0].words[0].text;

        // delete whitespaces.
        _resultText = _resultText.replaceAll(RegExp(r'\s+'), '');

        if (isCarPlateNumber(_resultText) == false) {
          _resultText = '';
        }

        // TODO: This debugging code should be deleted.
        // print('[junyoung.ahn] ▶▶▶ _resultText : ' + _resultText);
      }
      else {
        // TODO: This debugging code should be deleted.
        print('[junyoung.ahn] ▶▶▶ response.statusCode = ' + response.statusCode.toString());
      }
    }
    catch (e) {
      print('[junyoung.ahn] API Exception ▶▶▶ ' + e.toString());
    }

    return _resultText;
  }

}