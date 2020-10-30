bool isCarPlateNumber(String text) {
  // delete whitespaces.
  text = text.replaceAll(RegExp(r'\s+'), '');

  // 7자리(12가4567) 또는 8자리(123가5678) 번호판 여부 체크
  return RegExp(r'[0-9]{2,3}[가-힣]{1}[0-9]{4}').hasMatch(text);
}