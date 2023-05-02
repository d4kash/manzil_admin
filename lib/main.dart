import 'package:Manzil_admin/screen/confirmBooking.dart';
import 'package:Manzil_admin/screen/reqRide.dart';
import 'package:Manzil_admin/widget/ExitDialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:Manzil_admin/screen/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'Network/connectivity_provider.dart';
import 'chatCode/Authenticate/Autheticate.dart';
import 'chatCode/Screens/ChatScreen.dart';
import 'screen/TravelHistory.dart';
import 'screen/requestedRide.dart';
import 'screen/waitingUser.dart';
import 'splashScreen/splash.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: Authenticate(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Manzil_admin',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: SplashScreen(),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/Home': (context) => MyHomePage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/ConfirmBook': (context) => const BookingConfirmation(),
          '/userWaiting': (context) => WaitingUser(),
          '/Req': (context) => Req(),
          '/userTravelHistory': (context) => UserTravelHistory(),
          '/ReqRide': (context) => RequestedRide(),
          '/chat': (context) => ChatHomeScreen(),
        },
      ),
    );
  }
}
