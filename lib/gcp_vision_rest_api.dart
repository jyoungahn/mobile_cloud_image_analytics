
import 'package:flutter/material.dart';
import 'dart:async';
import 'ocr_models/google_cloud_vision.dart';

class MyGoogleVisionRestAPI extends StatefulWidget {
  MyGoogleVisionRestAPI({Key key}) : super(key: key);

  @override
  _MyGoogleVisionRestAPIState createState() {
    return _MyGoogleVisionRestAPIState();
  }
}

class _MyGoogleVisionRestAPIState extends State<MyGoogleVisionRestAPI> {
  GoogleCloudVision _googleCloudVision = GoogleCloudVision();
  Future<String> _futureTextRecognition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Vision Rest API call Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureTextRecognition == null)
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Send Request'),
              onPressed: () {
                setState(() {
                  _futureTextRecognition =
                      _googleCloudVision.readText();
                  print('Call createTextRecognition');
                });
              },
            ),
          ],
        )
            : FutureBuilder<String>(
          future: _futureTextRecognition,
          builder: (context, snapshot) {
            print('Begin of FutureBuilder');
            if (snapshot.hasData) {
              return Text(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}