import 'dart:ui';

import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/AboutApp.dart';
import 'package:coller_mobile/view/Profile/ChangePassword.dart';
import 'package:coller_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controller/DemoController.dart';
import '../../theme.dart';
import 'EditProfile.dart';

class OverviewProfile extends StatefulWidget {
  @override
  State<OverviewProfile> createState() => _OverviewProfileState();
}

class _OverviewProfileState extends State<OverviewProfile> {
  var currentIndex = 3;
  final DemoController ctrl = Get.find();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // InkWell(
                    //   child: Container(
                    //     width: 35,
                    //     height: 35,
                    //     decoration: BoxDecoration(
                    //         color: redColor,
                    //         borderRadius: BorderRadius.circular(50)),
                    //     child: Icon(
                    //       Icons.chevron_left,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (context) => EditProfile()),
                    //     // );
                    //   },
                    // ),

                    Text(
                      "Profile.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff949494)),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // )
                  ],
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ctrl.isDark
                                ? Color.fromARGB(31, 206, 206, 206)
                                : bgLightRedColor,
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
                              SizedBox(height: 20),
                              Text(
                                uProfile.nama_lengkap.toString(),
                                style: ctrl.isDark
                                    ? TextStyle(
                                        color: Color(0xffA7A7A7),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)
                                    : titleTextStyle,
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
                                  ).then((value) {
                                    setState(() {});
                                  });
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
                            color: ctrl.isDark
                                ? Color.fromARGB(31, 206, 206, 206)
                                : bgLightRedColor,
                            borderRadius: BorderRadius.circular(22)),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.dark_mode_outlined,
                                        color:
                                            Color.fromARGB(255, 147, 147, 147),
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
                                  // IconButton(
                                  //   icon: Icon(Icons.toggle_off_outlined),
                                  //   color: Color.fromARGB(255, 147, 147, 147),
                                  //   onPressed: () {},
                                  // )
                                  // Switch(
                                  //   value: isDarkMode,
                                  //   onChanged: (value) => appdata.write('darkmode', value),
                                  // )
                                  Switch(
                                    value: ctrl.isDark,
                                    onChanged: ctrl.changeTheme,
                                  ),
                                ],
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AboutApp()),
                                  );
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
                    showAlertLogout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertLogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to Logout?'),
            // content: Text('We hate to see you leave...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
