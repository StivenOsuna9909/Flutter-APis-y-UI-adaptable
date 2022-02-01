import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:interfaz_/api/authentication_api.dart';
import 'package:interfaz_/data/authentication_client.dart';
import 'package:interfaz_/pages/home_page.dart';
import 'package:interfaz_/utils/dialogs.dart';
import 'package:interfaz_/utils/responsive.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authenticationAPI = GetIt.instance<AuthenticationAPI>();
  final _authenticationClient = GetIt.instance<AuthenticationClient>();

  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';

  Future<void> _submit() async {
    final isOk = _formKey.currentState!.validate();
    if (isOk) {
      ProgressDialog.show(context);
      final response = await _authenticationAPI.login(
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
        } else if (response.error?.statusCode == 403) {
          message = 'Invalid password';
        } else if (response.error?.statusCode == 404) {
          message = 'User not found';
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
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.black12,
                ))),
                child: Row(
                  children: [
                    Expanded(
                      child: InputText(
                        label: 'PASSWORD',
                        obscureText: true,
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        OnChanged: (text) {
                          _password = text;
                        },
                        validator: (text) {
                          if (text?.trim().length == 0) {
                            return 'Invalid password';
                          }
                        },
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                responsive.dp(responsive.isTablet ? 1.2 : 1.5)),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: responsive.dp(5),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white, fontSize: responsive.dp(1.5)),
                    ),
                    onPressed: this._submit,
                  ),
                ),
              ),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to Friendly Desi?',
                    style: TextStyle(
                        fontSize: responsive.dp(1.5), color: Colors.black26),
                  ),
                  FlatButton(
                    child: Text(
                      'Sig up',
                      style: TextStyle(
                        color: Color(0xffF7B3C2),
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
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
