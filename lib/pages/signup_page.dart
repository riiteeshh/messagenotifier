import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:message_notifier/static/form_decoration.dart';
import 'package:message_notifier/validator/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final name = TextEditingController();
  final nickname = TextEditingController();
  final address = TextEditingController();
  final number = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var dbref = FirebaseFirestore.instance.collection('UserData');
  bool wait = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp')),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    validator: (value) => namevalidator(value),
                    controller: name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        formdecoration(hint: 'John Mayer', label: 'Full-Name'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateNumber(value),
                    decoration:
                        formdecoration(hint: '982121212', label: 'Number'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: address,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => namevalidator(value),
                    decoration:
                        formdecoration(hint: 'Texas,NY', label: 'Address'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateEmail(value),
                    decoration: formdecoration(
                        hint: 'john mayer @abc.com', label: 'E-mail address'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: password,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validatePassword(value),
                    obscuringCharacter: '*',
                    obscureText: true,
                    decoration: formdecoration(hint: '***', label: 'Password'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.065,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        uploadData();
                      }
                    },
                    child: wait
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'SignUp',
                            style: TextStyle(fontSize: 19),
                          ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void uploadData() async {
    setState(() {
      wait = true;
    });
    Map<String, dynamic> users = {
      'name': name.text.toUpperCase(),
      'number': number.text,
      'address': address.text.toUpperCase(),
      'emailAddress': email.text.toUpperCase(),
      'password': password.text,
      'messagebit': 0,
      'message': ''
    };
    await dbref.add(users);
    setState(() {
      wait = false;
    });
    Navigator.pop(context);
  }
}
