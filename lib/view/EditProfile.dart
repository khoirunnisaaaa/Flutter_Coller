import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                    Text("Edit Profile.", style: mainTitleTextStyle),
                    SizedBox(
                      width: 35,
                    )
                  ],
                ),
                SizedBox(height: 45),
                Center(
                  child: Stack(
                    children: [
                      Image.asset("assets/images/profile.png"),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: redColor,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 35),
                Text(
                  "Full Name",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: searchCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    hintText: 'Irene Bae',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Email Address",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: searchCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    hintText: 'irenebae@gmail.com',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Telephone",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  // controller: searchCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    hintText: '+1 2374 2389 21',
                    hintStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                InkWell(
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: redColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
