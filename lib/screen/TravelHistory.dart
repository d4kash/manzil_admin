import 'package:flutter/material.dart';

import 'HomePage.dart';

class UserTravelHistory extends StatefulWidget {
  UserTravelHistory({Key? key}) : super(key: key);

  @override
  _UserTravelHistoryState createState() => _UserTravelHistoryState();
}

class _UserTravelHistoryState extends State<UserTravelHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Travel History"),
              leading: InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, '/Home', (route) => false)),
            ),
            body: Container(child: Text("user travel history"))));
  }
}
