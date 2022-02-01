import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interfaz_/api/account_api.dart';
import 'package:interfaz_/data/authentication_client.dart';
import 'package:interfaz_/models/user.dart';
import 'package:interfaz_/pages/login_page.dart';
import 'package:interfaz_/utils/logs.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authenticationClient = GetIt.instance<AuthenticationClient>();
  final _accountAPI = GetIt.instance<AccountAPI>();

  User? _user;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadUser();
    });
  }

  Future<void> _loadUser() async {
    try {
      final response = await _accountAPI.getUserInfo();
      if (response?.data != null) {
        _user = response?.data;
        setState(() {});
      }
    } catch (e) {
      print('Estoy acá');
    }
  }

  Future<void> _signOut() async {
    await _authenticationClient.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      LoginPage.routeName,
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_user == null) CircularProgressIndicator(),
            if (_user != null)
              Column(
                children: [
                  Text(_user!.id),
                  Text(_user!.username),
                  Text(_user!.email),
                  Text(
                    _user!.createdAt.toIso8601String(),
                  ),
                ],
              ),
            FlatButton(
              onPressed: _signOut,
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
