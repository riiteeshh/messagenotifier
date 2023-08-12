import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:message_notifier/pages/home_page.dart';
import 'package:message_notifier/pages/login_page.dart';
import 'package:message_notifier/services/background_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      print('permission req');
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp();
  // await initializeService();
  print('done initialize service');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Colors.amber,
        elevation: 0,
        centerTitle: true,
      )),
      home: LoginPage(),
    );
  }
}
