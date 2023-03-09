import 'package:flutter/material.dart';
import 'package:flutter_php/add.dart';
import 'package:flutter_php/edit.dart';
import 'package:flutter_php/home.dart';
import 'package:flutter_php/signup.dart';
import 'package:flutter_php/success.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: sharedPref.getString("id") == null ? "login" : "home",
      routes: {
        "home": ((context) => HomePage()),
        "login": ((context) => LogIn()),
        "Signup": ((context) => SignUp()),
        "success": ((context) => Success()),
        "add": ((context) => AddNotes()),
        // "edit": ((context) => EditNote()),
      },
    );
  }
}
