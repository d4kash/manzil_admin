import 'package:Manzil_admin/screen/requestedRide.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Manzil_admin/chatCode/Authenticate/LoginScreen.dart';
import 'package:Manzil_admin/chatCode/Screens/ChatScreen.dart';
// import 'package:Manzil_admin/screens/vehicles/vehicleSelection.dart';
import 'package:Manzil_admin/screen/HomePage.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return MyHomePage();
    } else {
      return LoginScreen();
    }
  }
}
