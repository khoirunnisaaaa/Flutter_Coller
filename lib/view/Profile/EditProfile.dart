import 'dart:io';
import 'dart:ui';

import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/Profile/ChangeEmail.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../theme.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final DemoController ctrl = Get.find();

  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _profImgController = TextEditingController();

  bool isLoading = false;
  File? _pickedImage;

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    setState(() {
      isLoading = true;
    });

    if (image != null) {
      String locationImg = 'prof_img/${image.name}';
      final file = File(image.path);

      Reference ref = FirebaseStorage.instance.ref().child(locationImg);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      final downloadUrl = await snapshot.ref.getDownloadURL();
      print("Download Link : " + downloadUrl);

      uProfile.updateProfile(
          email: uProfile.email.toString(),
          password: uProfile.password.toString(),
          nama_lengkap: uProfile.nama_lengkap.toString(),
          no_hp: uProfile.no_hp.toString(),
          prof_img: downloadUrl);

      setState(() {
        isLoading = false;
        _pickedImage = file;
      });

      uProfile.getUserDoc();
    }
  }

  _imageOption() async {
    showCupertinoDialog(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text("Choose image source"), actions: [
        FlatButton(
            child: Text("Camera"),
            onPressed: () async {
              PermissionStatus cameraStatus = await Permission.camera.request();

              if (cameraStatus == PermissionStatus.granted) {
                Navigator.pop(context, pickImage(ImageSource.camera));
              } else if (cameraStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Please grant permission!'),
                ));
              }
            }),
        FlatButton(
            child: Text("Gallery"),
            onPressed: () async {
              PermissionStatus storageStatus =
                  await Permission.storage.request();

              if (storageStatus == PermissionStatus.granted) {
                Navigator.pop(context, pickImage(ImageSource.gallery));
              } else if (storageStatus == PermissionStatus.denied) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Please grant permission!'),
                ));
              }
            }),
      ]),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _namaController.text = uProfile.nama_lengkap.toString();
    _emailController.text = uProfile.email.toString();
    _phoneController.text = uProfile.no_hp.toString();
    _profImgController.text = uProfile.prof_img.toString();
    super.initState();
  }

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
                        // Navigator.pop(context)
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => navbar(index: 3)),
                        );
                      },
                    ),
                    Text(
                      'Edit Profile',
                      style: ctrl.isDark
                          ? TextStyle(fontWeight: FontWeight.w600, fontSize: 18)
                          : mainTitleTextStyle,
                    ),
                    SizedBox(
                      width: 30,
                    )
                  ],
                ),
                SizedBox(height: 45),
                Center(
                    child: InkWell(
                  child: Stack(
                    children: [
                      isLoading
                          ? CircleAvatar(
                              radius: 90.0,
                              backgroundColor:
                                  Color.fromARGB(255, 190, 193, 196),
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            )
                          : CircleAvatar(
                              radius: 90.0,
                              backgroundColor: const Color(0xFF778899),
                              backgroundImage: _pickedImage != null
                                  ? FileImage(_pickedImage as File)
                                  : NetworkImage(uProfile.prof_img.toString())
                                      as ImageProvider, // for Network image,
                            ),
                      Positioned(
                        right: 15,
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
                  onTap: () {
                    _imageOption();
                  },
                )),
                SizedBox(height: 35),
                Text(
                  "Full Name",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _namaController,
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
                    hintText: uProfile.nama_lengkap.toString(),
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
                ),
                SizedBox(height: 20),
                Text(
                  "Email Address",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _emailController,
                  // controller: searchCtrl,
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 183, 183, 183),
                          width: 0.0),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    // hintText: uProfile.email.toString(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangeEmail()),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Telephone",
                  style: titleTFEditProfile,
                ),
                SizedBox(height: 5),
                TextField(
                  controller: _phoneController,
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
                    hintText: uProfile.no_hp.toString(),
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
                        "Save",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  onTap: () {
                    showAlertConfirmation();
                    // uProfile.email = _emailController.text;
                    // uProfile.nama_lengkap = _namaController.text;
                    // uProfile.no_hp = _phoneController.text;
                    // uProfile.prof_img = _profImgController.text;
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
    );
  }

  showAlertConfirmation() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to edit your profile?'),
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
                  uProfile.updateProfile(
                      email: uProfile.email.toString(),
                      nama_lengkap: _namaController.text,
                      password: uProfile.password.toString(),
                      no_hp: _phoneController.text,
                      prof_img: _profImgController.text);

                  uProfile.getUserDoc();
                  Navigator.of(context).pop(true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Profile Updated!'),
                  ));
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
