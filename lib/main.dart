import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_cloud_image_analytics/common/theme.dart';
import 'package:mobile_cloud_image_analytics/data/demo_data.dart';
import 'package:mobile_cloud_image_analytics/pages/login.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_start.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_camera_control.dart';
import 'package:mobile_cloud_image_analytics/pages/demo_result.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginInfo()),
        ChangeNotifierProvider(create: (context) => OcrModel()),
        ChangeNotifierProvider(create: (context) => MobileInfo()),
      ],
      child: DemoApp(),
    ));
    }
  );
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile/Cloud Image Analytics DEMO',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/demo-start': (context) => DemoStartPage(),
        '/demo-camera-control': (context) => DemoCameraControlPage(),
        '/demo-result': (context) => DemoResultPage(),
      },
      theme: appTheme,
    );
  }
}
