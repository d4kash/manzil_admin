import 'package:Manzil_admin/helper/constants.dart';
import 'package:Manzil_admin/main.dart';
import 'package:Manzil_admin/screen/waitingUser.dart';
import 'package:Manzil_admin/widget/ExitDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'TravelHistory.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<void> saveTokenToDatabase(String token) async {
  // Assume user is logged in for this example
  String userId = "$UID";

  await FirebaseFirestore.instance.collection('users').doc(userId).update({
    'tokens': FieldValue.arrayUnion([token]),
  });
}

class _MyHomePageState extends State<MyHomePage> {
  // late String _token;
  var TOKEN;
  void getToken() async {
    "${await FirebaseMessaging.instance.getToken().then((value) => {
          setState(() {
            TOKEN = value;
          })
        })}";
    // print(TOKEN);
  }

  @override
  void initState() {
    super.initState();
    // Get the token each time the application loads
    // String? token =  FirebaseMessaging.instance.getToken();
    // getToken();
    // print(TOKEN);

    // // Save the initial token to the database
    // await saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            // message.data.hashCode,
            // message.data['title'],
            // message.data['body'],
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> page = ["waiting user", "History", "RequestedRide", "req"];
    return WillPopScope(
      onWillPop: () async => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: GridView.builder(
              itemCount: page.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: Card(
                      color: Colors.deepOrange.shade200,
                      child: Center(
                        child: Text(
                          page[index],
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 22),
                        ),
                      )),
                  onTap: () {
                    switch (index) {
                      case 0:
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (_) => WaitingUser()));
                        Navigator.pushReplacementNamed(context, '/userWaiting');
                        break;
                      case 1:
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => UserTeavelHistory()));
                        Navigator.pushReplacementNamed(
                            context, '/userTravelHistory');
                        break;
                      case 2:
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => UserTeavelHistory()));
                        Navigator.pushReplacementNamed(context, '/ReqRide');
                        break;
                      case 3:
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => UserTeavelHistory()));
                        Navigator.pushReplacementNamed(context, '/Req');
                        break;
                      default:
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
