import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notoficationmodel {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future shownotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher

    await _notification.initialize(
      InitializationSettings(android: initializationSettingsAndroid),
    );
    _notification.show(
      id, title, body, await _notificationDetails(),
      //payload: payload
    );
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc(payload)
        .update({
      'messagebit': 0,
    });
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max));
  }
}
