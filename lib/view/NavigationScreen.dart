import 'package:coller_mobile/theme.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg-welcome-screen2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        "Manage Your",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        "College Lifestyle",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFFE299)),
                      ),
                      Text(
                        "with Us!",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(height: 25),
                      Image.asset(
                        "images/ic_man_sitting.png",
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: redColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Register()),
                          // );
                        },
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset:
                                    Offset(0, 10), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Log-In",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => Login()),
                          // );
                        },
                      )
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
