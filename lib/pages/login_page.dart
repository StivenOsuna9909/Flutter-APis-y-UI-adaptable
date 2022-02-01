import 'package:flutter/material.dart';
import 'package:interfaz_/utils/responsive.dart';
import 'package:interfaz_/widgets/circle.dart';
import 'package:interfaz_/widgets/icon_container.dart';
import 'package:interfaz_/widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final double pinkSize = responsive.wp(80);
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
                    top: -pinkSize * 0.4,
                    right: -pinkSize * 0.2,
                    child: Opacity(
                      opacity: 0.80,
                      child: Circle(
                        size: responsive.wp(80),
                        colors: [Colors.pinkAccent, Colors.pink],
                      ),
                    )),
                Positioned(
                  top: -orangeSize * 0.55,
                  left: -orangeSize * 0.15,
                  child: Circle(
                    size: orangeSize,
                    colors: [Colors.yellow.shade400, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.62,
                  right: orangeSize * 1.22,
                  child: Circle(
                    size: 6,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.72,
                  right: orangeSize * 1.10,
                  child: Circle(
                    size: 10,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.85,
                  right: orangeSize * 1.20,
                  child: Circle(
                    size: 5,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                //circulos lado derecho
                Positioned(
                  bottom: orangeSize * 2.58,
                  right: orangeSize * 0.45,
                  child: Circle(
                    size: 12,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.75,
                  right: orangeSize * 0.65,
                  child: Circle(
                    size: 5,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  bottom: orangeSize * 2.86,
                  right: orangeSize * 0.55,
                  child: Circle(
                    size: 8,
                    colors: [Colors.orange.shade200, Colors.red.shade200],
                  ),
                ),
                Positioned(
                  top: pinkSize * 0.35,
                  child: Column(
                    children: [
                      IconContainer(
                        size: responsive.wp(17),
                      ),
                      SizedBox(
                        height: responsive.dp(3),
                      ),
                      Text('Hello Again\nWelcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: responsive.dp(1.6),
                              color: Colors.black45))
                    ],
                  ),
                ),
                LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
