import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interfaz_/utils/responsive.dart';
import 'package:interfaz_/widgets/avatar_button.dart';
import 'package:interfaz_/widgets/circle.dart';
import 'package:interfaz_/widgets/register_form.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = 'register';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(88);
    final double orangeSize = responsive.wp(57);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: -pinkSize * 0.3,
                    right: -pinkSize * 0.2,
                    child: Opacity(
                      opacity: 0.80,
                      child: Circle(
                        size: responsive.wp(80),
                        colors: [Colors.pinkAccent, Colors.pink],
                      ),
                    )),
                Positioned(
                  top: -orangeSize * 0.35,
                  left: -orangeSize * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: [Colors.yellow.shade400, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.60,
                  right: orangeSize * 1.27,
                  child: Circle(
                    size: 4,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.45,
                  right: orangeSize * 1.17,
                  child: Circle(
                    size: 9,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.32,
                  right: orangeSize * 1.35,
                  child: Circle(
                    size: 6,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                //circulos lado derecho
                Positioned(
                  bottom: orangeSize * 2.72,
                  right: orangeSize * 0.46,
                  child: Circle(
                    size: 7,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.60,
                  right: orangeSize * 0.55,
                  child: Circle(
                    size: 4,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.48,
                  right: orangeSize * 0.37,
                  child: Circle(
                    size: 10,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  top: pinkSize * 0.22,
                  child: Column(
                    children: [
                      Text(
                        'Hello\n Sign up to get started.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: responsive.dp(1.6), color: Colors.white),
                      ),
                      SizedBox(
                        height: responsive.dp(4.5),
                      ),
                      AvatarButton(
                        imageSize: responsive.wp(25),
                      )
                    ],
                  ),
                ),
                RegisterForm(),
                Positioned(
                  left: 15,
                  top: 10,
                  child: SafeArea(
                    child: CupertinoButton(
                      color: Colors.black26,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(30),
                      child: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
