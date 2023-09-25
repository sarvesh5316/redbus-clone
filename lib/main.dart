// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:redbus/pages/loginpage.dart';
import 'package:redbus/widgets/theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lighttheme(context),
      darkTheme: MyTheme.darktheme(context),
      home: LoginPage(),
      /*  initialRoute: "login",
      routes: {
        "/": (context) => LoginPage(),
      //  "home": (context) => HomePage(),
        "login": (context) => LoginPage(),
        "signup": (context) => SignupPage(),
      },*/
    );
  }
}
