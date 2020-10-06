import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:mobile_number/mobile_number.dart';
import 'package:device_info/device_info.dart';
import 'package:sim_info/sim_info.dart';
// import 'package:imei_plugin/imei_plugin.dart';
// import "package:serial_number/serial_number.dart";
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textId = TextEditingController();
  final _textPw = TextEditingController();

  LoginInfo _loginInfo;
  MobileInfo _mobileInfo;
  String _mobileNumber;
  String _carrierName;
  String _mobileNetworkCode;
  String _isoCountryCode;
  String _mobileCountryCode;
  // String _imei;
  // String _serialNumber;
  // String _macAddress;
  Position _position;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      initAndroidState();
    } else if (Platform.isIOS) {
      initIosState();
    }
  }

  Future<void> initAndroidState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }

    try {
      _deviceData = _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo);
      _mobileNumber = await MobileNumber.mobileNumber;
      _carrierName = await SimInfo.getCarrierName;
      _isoCountryCode = await SimInfo.getIsoCountryCode;
      _mobileCountryCode = await SimInfo.getMobileCountryCode;
      _mobileNetworkCode = await SimInfo.getMobileNetworkCode;
      // _imei = await ImeiPlugin.getImei();
      // _serialNumber = await SerialNumber.serialNumber;
      // _macAddress = await SerialNumber.macAddress;
      _position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    } on PlatformException {
      // TBD: more detail exception control
      _mobileNumber = 'Failed to get mobile number.';
      _deviceData = <String, dynamic>{
        'Error': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;
  }

  Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo data) {
    return <String, dynamic>{
      'version.securityPatch': data.version.securityPatch,
      'version.sdkInt': data.version.sdkInt,
      'version.release': data.version.release,
      'version.previewSdkInt': data.version.previewSdkInt,
      'version.incremental': data.version.incremental,
      'version.codename': data.version.codename,
      'version.baseOS': data.version.baseOS,
      'board': data.board,
      'bootloader': data.bootloader,
      'brand': data.brand,
      'device': data.device,
      'display': data.display,
      'fingerprint': data.fingerprint,
      'hardware': data.hardware,
      'host': data.host,
      'id': data.id,
      'manufacturer': data.manufacturer,
      'model': data.model,
      'product': data.product,
      'supported32BitAbis': data.supported32BitAbis,
      'supported64BitAbis': data.supported64BitAbis,
      'supportedAbis': data.supportedAbis,
      'tags': data.tags,
      'type': data.type,
      'isPhysicalDevice': data.isPhysicalDevice,
      'androidId': data.androidId,
      'systemFeatures': data.systemFeatures,
    };
  }

  Future<void> initIosState() async {
    try {
      _deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    } on PlatformException {
      _deviceData = <String, dynamic>{
        'Error': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _textId.dispose();
    _textPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get LoginInfo from Provider.
    _loginInfo = Provider.of<LoginInfo>(context, listen: false);
    _mobileInfo = Provider.of<MobileInfo>(context, listen: false);

    return Scaffold(
      // body: Center(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Mobile/Cloud',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Center(
                  child: Text(
                    '이미지분석 PoC',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _textId,
                  decoration: InputDecoration(
                    labelText: 'ID : ',
                    hintText: 'Username',
                  ),
                ),
                TextFormField(
                  controller: _textPw,
                  decoration: InputDecoration(
                    labelText: 'PW : ',
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.lightBlue[200],
                  child: Text('로그인'),
                  onPressed: () {
                    if (_textId.text == 'da' && _textPw.text == 'da') {
                      _loginInfo.id = 'da';
                      _loginInfo.name = '삼성화재 Data Analytics파트';
                      _mobileInfo.phoneNumber = _mobileNumber;
                      _mobileInfo.carrierName = _carrierName;
                      _mobileInfo.mobileNetworkCode = _mobileNetworkCode;
                      _mobileInfo.isoCountryCode = _isoCountryCode;
                      _mobileInfo.mobileCountryCode = _mobileCountryCode;
                      // _mobileInfo.imeiNumber = _imei;
                      // _mobileInfo.makerSerialNumber = _serialNumber;
                      // _mobileInfo.macAddress = _macAddress;
                      _mobileInfo.makerName = _deviceData['manufacturer'];
                      _mobileInfo.makerModelName = _deviceData['product'];
                      _mobileInfo.makerModelNumber = _deviceData['model'];
                      if (_position != null) {
                        _mobileInfo.locationLatitude =
                            _position.latitude.toString();
                        _mobileInfo.locationLongitude =
                            _position.longitude.toString();
                      }


                      Navigator.pushReplacementNamed(context, '/demo-start');
                    } else {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Center(
                                child: Text(
                                  '로그인 실패',
                                  style: TextStyle(
                                      color: Colors.lightBlue,
                                      fontWeight: FontWeight.bold),
                                )),
                            content: Text('ID와 패스워드를 확인하세요.'),
                            actions: <Widget>[
                              RaisedButton(
                                child: Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Center(
                    child: Text('삼성화재 Data Analytics파트',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.lightBlue,
                            fontStyle: FontStyle.italic))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
