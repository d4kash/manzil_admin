import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const String DBUSER = "user";
const String DBUSER_PROFILE = "users";
String UID = "${FirebaseAuth.instance.currentUser!.uid}";
// String TOKEN = "${FirebaseMessaging.instance.getToken()}";

