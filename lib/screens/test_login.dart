import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../utils/color_util.dart';

class TestLogin extends StatefulWidget {
  const TestLogin({super.key});

  @override
  State<TestLogin> createState() => _TestLoginState();
}

class _TestLoginState extends State<TestLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#00ffb7"),
          hexStringToColor("#6400ff")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _federatedLoginButton("Google",
              "/Users/travistyler/development/nwm_river_forecast/assets/images/google.png"),
          _federatedLoginButton("Apple",
              "/Users/travistyler/development/nwm_river_forecast/assets/images/apple.png"),
        ]),
      ),
    );
  }

  Widget _federatedLoginButton(String federation, String fedIconPath) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () async {
              print("hello world");
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            })),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Image.asset(fedIconPath, width: 40, height: 40),
                    ),
                    Text("Login with " + federation,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                  ]),
            ),
          )),
    );
  }
}
