import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../theme.dart';

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final DemoController ctrl = Get.find();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  changePass(String newPass) async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firebaseAuth.currentUser?.updatePassword(newPass).then((value) {
        uProfile.updateProfile(
            email: uProfile.email.toString(),
            password: _newPassController.text,
            nama_lengkap: uProfile.nama_lengkap.toString(),
            no_hp: uProfile.no_hp.toString(),
            prof_img: uProfile.prof_img.toString());
        uProfile.getUserDoc();

        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Password updated!'),
        ));
      }).then((value) => Navigator.of(context)
          .pop(MaterialPageRoute(builder: (context) => navbar(index: 3))));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

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
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => navbar(index: 3)),
                          );
                        },
                      ),
                      Text(
                        'Change Password',
                        style: ctrl.isDark
                            ? TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18)
                            : mainTitleTextStyle,
                      ),
                      SizedBox(
                        width: 30,
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
                    controller: _newPassController,
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
                            // color: Color.fromARGB(255, 183, 183, 183),
                            width: 0.0),
                      ),
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      } else if (value.length < 8) {
                        return 'Minimum password length is 8 characters';
                      } else if (value == uProfile.password.toString()) {
                        return 'Please choose other password.';
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
                    controller: _confPassController,
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
                            // color: Color.fromARGB(255, 183, 183, 183),
                            width: 0.0),
                      ),
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      } else if (value != _newPassController.text) {
                        return 'The password confirmation does not match';
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
                    controller: _passwordController,
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
                            // color: Color.fromARGB(255, 183, 183, 183),
                            width: 0.0),
                      ),
                      filled: true,
                      // fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'must be filled';
                      }
                      if (value != uProfile.password.toString()) {
                        return 'Wrong password!';
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
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                      ),
                    ),
                    onTap: () {
                      if (formGlobalKey.currentState!.validate()) {
                        // _formKey.currentState!.save();
                        showAlertConfirmation();
                        print("Sukses");
                      }
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

  showAlertConfirmation() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to change your password?'),
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
                  changePass(_newPassController.text);
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
