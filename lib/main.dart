import 'package:flutter/material.dart';
import 'package:golden_app/screens/estimate/estimate.dart';
import 'package:golden_app/screens/home/home.dart';
import 'package:golden_app/screens/login/login.dart';
import 'package:golden_app/screens/outlay/outlay.dart';
import 'package:golden_app/screens/provider/provider.dart';
import 'package:golden_app/screens/resource/resource_kitchen.dart';
import 'package:golden_app/screens/resource/resource_part.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // Future<dynamic> myBackgroundMessageHandler(
  //     Map<String, dynamic> message) async {
  //   if (message.containsKey('data')) {
  //     Handle data message
      // final dynamic data = message['data'];
    // }
    // if (message.containsKey('notification')) {
    //   Handle notification message
      // final dynamic notification = message['notification'];
    // }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golden Lavash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        LoginScreen.route: (context) => LoginScreen(),
        HomeScreen.route: (context) => HomeScreen(),
        EstimatePage.route: (context) => EstimatePage(),
        OutlayPage.route: (context) => OutlayPage(),
        ProviderPage.route: (context) => ProviderPage(),
        ResourcePartsPage.route: (context) => ResourcePartsPage(),
        ResourceKitchenPage.route: (context) => ResourceKitchenPage(),
      },
      home: LoginScreen(),
    );
  }
}
