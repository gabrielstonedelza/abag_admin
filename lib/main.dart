import 'package:abag_admin/homepage.dart';
import 'package:abag_admin/registration/registration.dart';
import 'package:abag_admin/success/success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.leftToRight,
      initialRoute: "/",
      getPages:  [
        GetPage(name: "/", page: ()=> const MySplashScreen()),
        GetPage(name: "/homepage", page: ()=> const HomePage()),
        GetPage(name: "/registration", page: ()=> const AgentRegistration()),
        GetPage(name: "/success", page: ()=> const RegistrationSuccess()),
      ],
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomePage(),
      duration: 4000,
      imageSize: 200,
      imageSrc: "assets/images/logo1.png",
      text: "Abag,yes we can",
      textType: TextType.TyperAnimatedText,
      textStyle: const TextStyle(
        fontSize: 30.0,
        color: primaryColor
      ),
      backgroundColor: Colors.white,
    );
  }
}