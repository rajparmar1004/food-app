import 'dart:async';

import 'package:charusat_food/screens/home_screen.dart';
import 'package:charusat_food/screens/landing_screen.dart';
import 'package:charusat_food/screens/main_screen.dart';
import 'package:charusat_food/screens/welcome_screen.dart';
import 'package:charusat_food/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Timer(
        Duration(
          seconds: 1,
        ), () {
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if (user == null) {
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        } else {
          getUserData();
        }
      });
    });
    super.initState();
  }

  getUserData() async {
    UserServices _userServices = UserServices();
    _userServices.getUserbyId(user.uid).then((result) {
      if (result.data()['address'] != null) {
        updatePrefs(result);
      }
      Navigator.pushReplacementNamed(context, LandingScreen.id);
    });
  }

  Future<void> updatePrefs(result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', result['latitude']);
    prefs.setDouble('longitude', result['longitude']);
    prefs.setString('address', result['address']);
    prefs.setString('location', result['location']);
    Navigator.pushReplacementNamed(context, MainScreen.id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/chef.png'),
          Text(
            'Charusat Food',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          )
        ],
      )
          //Hero(tag: 'logo', child: Image.asset('images/chef.png')),
          ),

//Center(
      //      child: Hero(tag: 'logo', child: Image.asset('images/chef.png')),
      //  ),
    );
  }
}
