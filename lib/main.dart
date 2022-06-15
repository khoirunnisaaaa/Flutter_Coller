import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notesAddItem.dart';
import 'package:coller_mobile/view/Dashboard.dart';
import 'package:coller_mobile/view/Income.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/register.dart';
import 'package:coller_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: _getSession(),
    );
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

          FirebaseFirestore.instance
              .collection("users")
              .doc(snapshot.data!.uid.toString())
              .get()
              .then((value) {
            uProfile.email = (value.data()!["email"]).toString();
            uProfile.nama_lengkap = (value.data()!["nama_lengkap"]).toString();
            uProfile.no_hp = (value.data()!["phone"]).toString();
            uProfile.prof_img = (value.data()!["prof_img"]).toString();
          });
          FirebaseFirestore.instance
              .collection("todolist")
              .doc(snapshot.data!.uid.toString())
              .collection("items")
              .get()
              .then((value) {
            uTodolist.todosLength = value.docs.length;
            print("Todos Length : " + value.docs.length.toString());
          });
          FirebaseFirestore.instance
              .collection("task")
              .doc(snapshot.data!.uid.toString())
              .collection("items")
              .where("status", isEqualTo: "false")
              .get()
              .then((value) {
            uTask.totalTask = value.docs.length;
            print("Task Length : " + value.docs.length.toString());
          });
          uIncome.getNama();
          uOutcome.getNama();
          return navbar();
        } else {
          return Login();
        }
      },
    );
  }
}
