import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:message_notifier/pages/login_page.dart';
import 'package:message_notifier/services/background_service.dart';
import 'package:message_notifier/shared/shared_prefs.dart';
import 'package:message_notifier/validator/validator.dart';
import 'package:message_notifier/components/notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final dbref = FirebaseFirestore.instance.collection('UserData');
    dynamic message;
    final locaion = TextEditingController();
    final alerts = TextEditingController();

    Future<dynamic> getAlert() async {
      print('rached funct');
      await initializeService();
      final service = FlutterBackgroundService();

      bool isRunning = await service.isRunning();
      if (isRunning) {
        print('reach service running');
        service.invoke('stopService');
      } else {
        print('reached else');
        service.startService();
      }
      if (!isRunning) {
        service.startService();
      }
      FlutterBackgroundService().invoke('setAsForeground');
      print('invoked');
      var id = await sharedpref.getdata('id');
      dbref.doc(id).snapshots().listen((event) {
        message = event.data();
        if (message['messagebit'] == 1) {
          print(event.data());
          notoficationmodel.shownotification(
              id: 0, title: 'ALERT', body: message['message'], payload: id);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: alerts,
                validator: (value) => validateMessage(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: null,
                decoration: InputDecoration(hintText: 'What\'s your message?'),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
                controller: locaion,
                validator: (value) => validateLocation(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(hintText: 'Location')),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
              child: Text('Send'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  dbref
                      .where('address', isEqualTo: locaion.text.toUpperCase())
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((element) async {
                      var idd;
                      idd = element.id;
                      dbref
                          .doc(idd)
                          .update({'messagebit': 1, 'message': alerts.text});
                    });
                  });
                }
              },
            ),
          ),
          Container(
            child: FutureBuilder(
              future: getAlert(),
              builder: (context, snapshot) {
                return Center(
                  child: Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
