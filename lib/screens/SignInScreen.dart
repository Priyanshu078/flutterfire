import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/utils/authentication.dart';
import 'package:flutterfire/widgets/GoogleSignInButton.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('FlutterFire'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset('assets/flutterfire.png'),
              Row(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text('Authentication by', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.lightBlue,
                  ),)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text('Firebase',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.amber,
                  ),)),
              SizedBox(
                height: 170,
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                  builder:(context, snapshot){
                    if(snapshot.hasError){
                      return Text('Error initializing Firebase');
                    }
                    else if(snapshot.connectionState == ConnectionState.done){
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                    );
                  },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
