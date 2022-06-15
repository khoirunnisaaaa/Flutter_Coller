import 'dart:ui';

import 'package:coller_mobile/utils/profile.dart';
import 'package:flutter/material.dart';

import '../../theme.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Form(
              key: formGlobalKey,
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
                      Text("Change Password.", style: mainTitleTextStyle),
                      SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  Text(
                    "New Password",
                    style: titleTFEditProfile,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    // controller: searchCtrl,
                    obscureText: true,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "New Password Confirmation",
                    style: titleTFEditProfile,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    // controller: searchCtrl,
                    obscureText: true,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Text(
                    "Old Password",
                    style: titleTFEditProfile,
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    // controller: searchCtrl,
                    obscureText: true,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      }
                      return null;
                    },
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
                      // print(_namaController.text +
                      //     " | " +
                      //     _emailController.text +
                      //     " | " +
                      //     _phoneController.text +
                      //     " | " +
                      //     _profImgController.text);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
