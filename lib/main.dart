import 'package:coller_mobile/view/Dashboard.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:coller_mobile/view/register.dart';
import 'package:coller_mobile/view/schedule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
      home: schedule(),
    );
  }
}
