import 'package:mobile_cloud_image_analytics/common/car_plate_number_check.dart';

void main() {

  String test = '';

  List<String> tests = List();

  tests.add('12호7535');
  tests.add('12호7535\n');
  tests.add('123호7535');
  tests.add('123 호7535');
  tests.add('123호 7 5  35');
  tests.add('1234호7535');
  tests.add('2호7535');
  
  tests.add('12호75');

  tests.forEach((test) {
    test = test.replaceAll(RegExp(r'\s+'), '');
    print('$test is car plate number? : ' + isCarPlateNumber(test).toString());
  });

}