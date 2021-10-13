import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire/utils/authentication.dart';

import 'SignInScreen.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key key, @required User user})
      : _user = user,
        super(key: key);

  final User _user;
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('FlutterFire'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            _user.photoURL != null
                ? ClipOval(
                    child: Material(
                      color: Colors.blueAccent.withOpacity(0.3),
                      child: Image.network(
                        _user.photoURL,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: Colors.blueAccent.withOpacity(0.3),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    color: Colors.amberAccent,
                  ),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text(
                _user.displayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.lightBlue,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Text(
                  '${_user.email}',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 16),
                child: Text(
                  'You are now signedIn with Google. \n To logout, Press the "Logout" button',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                )),
            if (_isSigningOut)
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            else
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _isSigningOut = true;
                  });
                  await Authentication.signOut(context: context);
                  setState(() {
                    _isSigningOut = false;
                  });
                  Navigator.of(context).pushReplacement(_routeToSignInScreen());
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
