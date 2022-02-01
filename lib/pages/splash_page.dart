import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interfaz_/data/authentication_client.dart';
import 'package:interfaz_/pages/home_page.dart';
import 'package:interfaz_/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final token = await _authenticationClient.accessToken;
    if (token == null) {
      Navigator.restorablePushReplacementNamed(context, LoginPage.routeName);
      return;
    }
    Navigator.restorablePushReplacementNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
