import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interfaz_/api/authentication_api.dart';
import 'package:interfaz_/data/authentication_client.dart';
import 'package:interfaz_/pages/home_page.dart';
import 'package:interfaz_/utils/dialogs.dart';
import 'package:interfaz_/utils/responsive.dart';
import 'package:logger/logger.dart';
import 'input_text.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '', _username = '';

  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.register(
        username: _username,
        email: _email,
        password: _password,
      );
      ProgressDialog.dismiss(context);
      if (response.data != null) {
        await _authenticationClient.saveSession(response.data!);
        Navigator.restorablePushNamedAndRemoveUntil(
          context,
          HomePage.routeName,
          (_) => false,
        );
      } else {
        String message = response.error!.message;
        if (response.error?.statusCode == -1) {
          message = 'Bad network';
        } else if (response.error?.statusCode == 409) {
          message =
              'Duplicated user ${jsonEncode(response.error?.data['duplicatedFields'])}';
        }

        Dialogs.alert(
          context,
          title: 'ERROR',
          description: message,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'USERNAME',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                OnChanged: (text) {
                  _username = text;
                },
                validator: (text) {
                  if (text!.trim().length < 5) {
                    return 'Invalid Username';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'EMAIL ADDRESS',
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                OnChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  var emailRegExp = new RegExp(
                      r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$');
                  if (text?.length == 0) {
                    return 'Este campo es requerido';
                  } else if (!emailRegExp.hasMatch(text!)) {
                    return "El formato para correo no es correcto";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: 'PASSWORD',
                obscureText: true,
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                OnChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text!.trim().length < 6) {
                    return 'Invalid password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                        color: Colors.white, fontSize: responsive.dp(1.5)),
                  ),
                  onPressed: this._submit,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        fontSize: responsive.dp(1.5), color: Colors.black38),
                  ),
                  FlatButton(
                    child: Text(
                      'Sig in',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: responsive.dp(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
