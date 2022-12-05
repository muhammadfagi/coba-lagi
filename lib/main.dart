import 'dart:io';
import 'package:flutter/material.dart';
import 'package:toko_online/login.dart';
import 'package:toko_online/screens/home.dart';
import 'dart:async';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Plugin must be initialized before using
  HttpOverrides.global = MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
