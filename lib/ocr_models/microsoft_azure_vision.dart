import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';
import 'package:mobile_cloud_image_analytics/data/azure_ocr_json_parser.dart';
import 'package:mobile_cloud_image_analytics/security/api_keys.dart';
import 'dart:convert';
import 'package:image/image.dart';


class AzureVision {
  String _resultText = '';

  Future<String> readText(String imagePath) async {
    String endpoint = 'https://sfmi-da-vision.cognitiveservices.azure.com';
    String language = 'ko';
    String detectOrientation = 'false';
    String url = '$endpoint/vision/v2.0/ocr?language=$language'
        '&detectOrientation=$detectOrientation';
    String azureApiKey = AZURE_API_KEY;

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
        print('--------------------------------------------------------------');
        print('Azure OCR API response.body ▶▶▶ ' + response.body);
        print('--------------------------------------------------------------');

        Map<String, dynamic> jsonText = jsonDecode(response.body);
        AzureOcrJsonParser azureOcrParser = AzureOcrJsonParser.fromJson(jsonText);

        azureOcrParser.regions[0].lines[0].words.forEach((word) {
          _resultText += ' ' + word.text;
        });

        _resultText = getCarPlateNumber(_resultText);

        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('Azure OCR API _resultText ▶▶▶ ' + _resultText);
        print('--------------------------------------------------------------');
      }
      else {
        print('--------------------------------------------------------------');
        print('Azure OCR API response.body ▶▶▶ ' + response.body);
        print('--------------------------------------------------------------');

        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('Azure OCR API response.statusCode ▶▶▶ ' + response.statusCode.toString());
        print('--------------------------------------------------------------');
      }
    }
    catch (e) {
      // TODO: This debugging code should be deleted.
      print('--------------------------------------------------------------');
      print('Azure OCR API Exception ▶▶▶ ' + e.toString());
      print('--------------------------------------------------------------');
    }

    return _resultText;
  }

}