import 'package:cov_bed/screens/bedscreen.dart';
import 'package:cov_bed/screens/permissions.dart';
import 'package:cov_bed/screens/profile.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:cov_bed/utlis/constants.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Widget _child = BedScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DashBoard"),
      ),
      body: _child,
      bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                iconPath: "assets/icons/dashboard.svg",
                extras: {"label": "DashBoard"}),
            FluidNavBarIcon(
                iconPath: "assets/icons/leaderboard.svg",
                extras: {"label": "LeaderBoard"}),
            FluidNavBarIcon(
                iconPath: "assets/icons/account_circle.svg",
                extras: {"label": "Profile"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
              barBackgroundColor: primaryColor,
              iconBackgroundColor: primaryColor,
              iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.white),
          scaleFactor: 2.0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras["label"],
            child: item,
          ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = BedScreen();
          break;
        case 1:
          _child = Permission();
          break;
        case 2:
          _child = Profile();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 200),
        child: _child,
      );
    });
  }
}
