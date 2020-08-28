import 'package:flutter/material.dart';

class Permission extends StatefulWidget {
  Permission({Key key}) : super(key: key);

  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Permission Page"),
      ),
    );
  }
}
