import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final int duration;
  final Widget goToPage;
  const SplashScreen({@required this.duration, @required this.goToPage});
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: this.duration), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => this.goToPage));
    });
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image(
            image: AssetImage('assets/firebase.png'),
          ),
        ),
      ),
    );
  }
}
