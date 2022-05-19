import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffE55957), Color(0xffE56357), Color(0xffE57957)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Image.asset(
              "images/coller-white-logo-large.png",
              width: 250,
              height: 220,
            ),
          ),
        ),
      ),
    );
  }
}
