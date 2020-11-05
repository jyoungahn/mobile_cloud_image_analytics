import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mobile_cloud_image_analytics/data/google_ocr_json_parser.dart';
import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';
import 'package:mobile_cloud_image_analytics/security/api_keys.dart';

class GoogleCloudVision {
  String _resultText = '';

  Future<String> readText(String imagePath) async {
    String gcpApiKey = GCP_API_KEY;
    String endpoint = 'https://vision.googleapis.com';
    String url = '$endpoint/v1/images:annotate?key=$gcpApiKey';

    String base64Image = base64Encode(File(imagePath).readAsBytesSync());

    try {
      Response response = await post(
        url,
        headers: <String, String> { "Content-Type": "application/json" },
        body: jsonEncode(<String, dynamic> {
          "requests": [
            { "image": { "content": "$base64Image" },
              "features": [ { "type": "TEXT_DETECTION" }]
            }],
        },),
      );

      if (response.statusCode == 200) {

        // TODO: This debugging code should be deleted.
        print('--------------------------------------------------------------');
        print('response.body ▶▶▶ ' + response.body);
        print('--------------------------------------------------------------');

        Map<String, dynamic> jsonText = jsonDecode(response.body);
        GoogleOcrJsonParser googleOcrParser = GoogleOcrJsonParser.fromJson(jsonText);

        _resultText = googleOcrParser.responses[0].fullTextAnnotation.text;

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
      print('Google Cloud API Exception ▶▶▶' + e.toString());
      print('--------------------------------------------------------------');
    }

    return _resultText;
  }
}