import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cov_bed/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //google signin
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final Firestore db = Firestore.instance;
  DocumentSnapshot userDetails;

  //Google Login
  Future<void> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    print(user.email + ' ' + user.photoUrl);
    db.collection('user').document(user.uid).get().then((value) {
      if (!value.exists) {
      FirebaseAuth.instance.signOut();
      AwesomeDialog(
        context: context,
        title: 'Permission Denied',
        desc:
            'You don\'t have enough Permission to enter. Please Contact your Administrator for access details',
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.ERROR,
        dismissOnBackKeyPress: true,
        dismissOnTouchOutside: true,
        useRootNavigator: true,
        btnCancelOnPress: () {
          dispose();
        },
      )..show();
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Bed"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.1,
          MediaQuery.of(context).size.height * 0.1,
          MediaQuery.of(context).size.width * 0.1,
          MediaQuery.of(context).size.height * 0.1,
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.asset(
                  'assets/cov-bed.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            Center(
              child: InkWell(
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                      )
                    ],
                    border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login With ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/google.png'),
                    ],
                  ),
                ),
                onTap: () {
                  _handleGoogleSignIn();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
