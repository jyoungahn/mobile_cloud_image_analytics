class TesseractOcrJsonParser {
  List<String> text;

  TesseractOcrJsonParser({this.text});

  TesseractOcrJsonParser.fromJson(Map<String, dynamic> json) {
    text = json['text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}