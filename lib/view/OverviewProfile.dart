import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class OverviewProfile extends StatefulWidget {
  @override
  State<OverviewProfile> createState() => _OverviewProfileState();
}

class _OverviewProfileState extends State<OverviewProfile> {
  var currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => EditProfile()),
                        // );
                      },
                    ),
                    Text("Profile.", style: mainTitleTextStyle),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgLightRedColor,
                            borderRadius: BorderRadius.circular(22)),
                        child: Padding(
                          padding: EdgeInsets.only(top: 30, bottom: 45),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/profile.png",
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Irene Bae",
                                style: titleTextStyle,
                              ),
                              Text(
                                "irenebae@gmail.com",
                                style: TextStyle(
                                    color: Color(0xff6F6F6F), fontSize: 13),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                child: Container(
                                  height: 40,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: redColor,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(0,
                                            10), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => EditProfile()),
                                  // );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  "SETTINGS",
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff949494),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: bgLightRedColor,
                            borderRadius: BorderRadius.circular(22)),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              InkWell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.dark_mode_outlined,
                                          color: Color.fromARGB(
                                              255, 147, 147, 147),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Dark Mode",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff6F6F6F)),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.toggle_off_outlined,
                                      color: Color.fromARGB(255, 147, 147, 147),
                                      size: 30,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => EditProfile()),
                                  // );
                                },
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.lock_outlined,
                                          color: Color.fromARGB(
                                              255, 147, 147, 147),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Change Password",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff6F6F6F)),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color.fromARGB(255, 147, 147, 147),
                                      size: 25,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => EditProfile()),
                                  // );
                                },
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.info_outlined,
                                          color: Color.fromARGB(
                                              255, 147, 147, 147),
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "About Application",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff6F6F6F)),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color.fromARGB(255, 147, 147, 147),
                                      size: 25,
                                    )
                                  ],
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => EditProfile()),
                                  // );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                Text(
                  "MY ACCOUNT",
                  style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff949494),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                InkWell(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: redColor),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Log-Out",
                              style: TextStyle(
                                  color: redColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => EditProfile()),
                    // );
                  },
                ),
                SizedBox(height: 15),
                InkWell(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffC7C7C7)),
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "Delete Account",
                              style: TextStyle(
                                  color: Color(0xffC7C7C7),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => EditProfile()),
                    // );
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [strongRedColor, Color(0xffF37970)]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  height: screenWidth * .3000,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == currentIndex ? screenWidth * .12 : 0,
                      width: index == currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.white
                            : Color(0xffFDE1E0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == currentIndex
                        ? strongRedColor
                        : Color(0xffFDE1E0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.school_rounded,
    Icons.monetization_on_rounded,
    Icons.person_rounded,
  ];
}