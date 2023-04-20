import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goose/Screens/Signuppage.dart';
import 'package:goose/Screens/homepage.dart';
import 'package:goose/Screens/navigatorpage.dart';
import 'package:goose/Screens/profilepage.dart';
import 'package:goose/Screens/uploadpost.dart';
import 'Screens/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const Loginpage()
          : const Navigatorpage(),
      getPages: AppRoutes.appRoutes,
    );
  }
}

class AppRoutes {
  static List<GetPage<dynamic>> appRoutes = [
    GetPage(name: "/loginpage", page: () => Loginpage()),
    GetPage(name: "/signuppage", page: () => const Signuppage()),
    GetPage(name: "/navigatorpage", page: () => const Navigatorpage()),
    GetPage(name: "/homepage", page: () => const Homepage()),
    GetPage(name: "/profilepage", page: () => const Profilepage()),
    GetPage(name: "/uploadpost", page: () => Uploadpost()),
  ];
}
