import 'package:flutter/material.dart';
import 'package:fluttershareexpense/my_application.dart';
import 'package:fluttershareexpense/ui/screens/home_screen.dart';
import 'package:fluttershareexpense/ui/screens/splash_screen.dart';

Future<void> main() async {
  await MyApplication.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Billing Valley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/index" : (_)=> SplashScreen(),
        "/home" : (_)=> HomeScreen(),
        "./" : (_)=> HomeScreen(),
        "/" : (_)=> HomeScreen(),
      },
      initialRoute: "/index",
    );
  }
}

