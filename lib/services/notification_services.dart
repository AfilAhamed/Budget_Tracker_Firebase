import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initilizeNotification() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    print(token);
  }
}
