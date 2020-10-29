import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class MyBase64Encoding {
  String _base64;

  Future<String> imageToBase64(String imagePath) async {
    final _imageFile = await rootBundle.load(imagePath);
    final _file = await writeToFile(_imageFile);
    final _byteFile = _file.readAsBytesSync();

    if (_byteFile != null) {
      _base64 = base64.encode(_byteFile);
      print('[bonggyun.park success!! ▶▶▶ ' + _base64);
    }
    else {
      _base64 = '';
      print('[bonggyun.park failed. ▶▶▶ ' + _base64);
    }

    return _base64;
  }
}

Future<File> writeToFile(ByteData data) async {
  final buffer = data.buffer;
  Directory tempDir = await getTemporaryDirectory();
  print('tempDir = ${tempDir}');
  String tempPath = tempDir.path;
  var filePath = tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
  return File(filePath).writeAsBytes(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}