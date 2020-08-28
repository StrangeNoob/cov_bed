import 'dart:async';
import 'package:cov_bed/screens/homepage.dart';
import 'package:cov_bed/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    var user = FirebaseAuth.instance.currentUser();
    if(user != null){
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage()));
    }else{
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Image.asset(
          'assets/cov-bed.png',
          width: animation.value * 250,
          height: animation.value * 250,
        ),
      ),
    );
  }
}