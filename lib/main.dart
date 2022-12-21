import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiffiny/Screens/Information.dart';
import 'package:tiffiny/Screens/home.dart';
import 'package:tiffiny/Screens/splash.dart';
import 'package:get/get.dart';
import 'Screens/phone.dart';
import 'Screens/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    initialRoute: 'splash',
    debugShowCheckedModeBanner: false,
    routes: {
      'splash': (context) => SplashScreen(),
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'home': (context) => MyHome(),
    },
  ));
}
