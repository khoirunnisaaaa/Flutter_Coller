import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/schedule.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notesAddItem.dart';
import 'package:coller_mobile/view/Dashboard.dart';
import 'package:coller_mobile/view/MoneyManagement/Income.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/register.dart';
import 'package:coller_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DemoController ctrl = Get.put(DemoController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(builder: (_) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(fontFamily: 'Poppins'),
        theme: ctrl.theme,
        home: _getSession(),
      );
    });
  }

  Widget _getSession() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // print(snapshot);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Something went wrong!"));
        } else if (snapshot.hasData) {
          uProfile.userUid = snapshot.data!.uid.toString();
          return navbar(index: 0);
        } else {
          return Login();
        }
      },
    );
  }
}
