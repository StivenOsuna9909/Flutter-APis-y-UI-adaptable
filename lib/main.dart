import 'package:flutter/material.dart';
import 'package:interfaz_/helpers/dependency_injection.dart';
import 'package:interfaz_/pages/home_page.dart';
import 'package:interfaz_/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:interfaz_/pages/register_page.dart';
import 'package:interfaz_/pages/splash_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        HomePage.routeName: (_) => HomePage(),
      },
    );
  }
}
