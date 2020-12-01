import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mobile_cloud_image_analytics/data/tesseract_ocr_json_parser.dart';
import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';

class TesseractOcr {
  String _resultText = '';

  Future<String> readText(String imagePath) async {
    String endpoint = 'http://sfmi-vision-ocr.koreacentral.azurecontainer.io:5000';
    String url = '$endpoint/';

    try {
      Response response = await post(
        url,
        headers: <String, String> { "Content-Type": "application/json" },
        body: jsonEncode(<String, dynamic> { "image": File(imagePath).readAsBytesSync() },
        ));

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

        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('response.statusCode ▶▶▶ ' + response.statusCode.toString());
        print('--------------------------------------------------------------');
      }
      else {
        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('response.statusCode ▶▶▶ ' + response.statusCode.toString());
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