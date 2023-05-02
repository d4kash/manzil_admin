import 'dart:async';

import 'package:Manzil_admin/chatCode/Authenticate/Autheticate.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Authenticate()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: Colors.yellow.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/images/caranimated.json"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DelayedDisplay(
                  delay: Duration(milliseconds: 1200),
                  slidingCurve: Curves.easeInOut,
                  child: Image.asset(
                    "assets/images/mr1.png",
                    height: 80,
                    width: 65,
                    color: Colors.red,
                    scale: 1,
                  ),
                  // child: Text("M",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 35.0,
                  //       color: Colors.red.shade500,
                  //     )),
                ),
                SizedBox(
                  width: 0,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 1000),
                  child: Text("A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.red.shade500,
                      )),
                ),
                SizedBox(
                  width: 7,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 900),
                  child: Text("N",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.red.shade500,
                      )),
                ),
                SizedBox(
                  width: 7,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 800),
                  child: Text("Z",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.red.shade500,
                      )),
                ),
                SizedBox(
                  width: 7,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 700),
                  child: Text("I",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.red.shade500,
                      )),
                ),
                SizedBox(
                  width: 7,
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 600),
                  child: Text("L",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: Colors.red.shade500,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
