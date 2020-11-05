String getCarPlateNumber(String text) {
  // Get the first car plate number.
  // 7자리(12가4567) 또는 8자리(123가5678) 번호판 여부 체크
  // 한글까지 정확히 매칭해야할 때 : RegExp(r'[0-9]{2,3}[가-힣]{1}[0-9]{4}')
  // Match firstMatch = RegExp(r'[0-9]{2,3}?[0-9]{4}').firstMatch(text);
  Match firstMatch = RegExp(r'[0-9]{2,3}[가-힣]{?}[0-9]{4}').firstMatch(text);
  text = text.substring(firstMatch.start, firstMatch.end);

  // delete whitespaces.
  // text = text.replaceAll(RegExp(r'\s+'), '');
  text = text.replaceAll(RegExp('/\s/g'), '');

  return text;
}