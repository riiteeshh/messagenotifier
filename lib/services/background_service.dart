import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_notifier/shared/shared_prefs.dart';
import 'package:message_notifier/components/notification.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
          autoStart: true,
          onForeground: onStart,
          onBackground: OnIosBackground),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
      ));
  service.startService();
}

@pragma('vm:entry-point')
Future<bool> OnIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      print('reached fore');

      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      print('reached back');
      service.setAsBackgroundService();
    });
    service.on('stopService').listen((event) {
      print('reached stop');
      service.stopSelf();
    });
  }
  //while starting service it take time so use timer
  Timer.periodic(Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        service.setForegroundNotificationInfo(
            title: 'MessageNotifier', content: 'Running in foreground');
      }
    }
    // perform task
    await Firebase.initializeApp();
    final dbref = FirebaseFirestore.instance.collection('UserData');
    print(DateTime.now().toString());
    dynamic message;
    var id = await sharedpref.getdata('id');
    dbref.doc(id).snapshots().listen((event) {
      message = event.data();
      print(message);
      if (message['messagebit'] == 1) {
        print(event.data());
        notoficationmodel.shownotification(
            id: 0, title: 'ALERT', body: message['message'], payload: id);
      }
    });
    service.invoke('update');
  });
}
