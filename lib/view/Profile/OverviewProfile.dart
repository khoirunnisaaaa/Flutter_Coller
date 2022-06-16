import 'dart:ui';

import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/Profile/ChangePassword.dart';
import 'package:coller_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme.dart';
import 'EditProfile.dart';

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
                              CircleAvatar(
                                radius: 55.0,
                                backgroundColor: const Color(0xFF778899),
                                backgroundImage: NetworkImage(uProfile.prof_img
                                    .toString()), // for Network image
                              ),
                              SizedBox(height: 10),
                              Text(
                                uProfile.nama_lengkap.toString(),
                                style: titleTextStyle,
                              ),
                              Text(
                                uProfile.email.toString(),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangePassword()),
                                  );
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
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
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
    );
  }
}
