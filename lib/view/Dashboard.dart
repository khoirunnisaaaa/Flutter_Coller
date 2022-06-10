import 'dart:ui';

import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/notes.dart';
import 'package:coller_mobile/utils/CollageManagement/schedule.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/view/CMMenu.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notesAddItem.dart';
import 'package:coller_mobile/view/CollageManagement/schedule.dart';
import 'package:coller_mobile/view/CollageManagement/task.dart';
import 'package:coller_mobile/view/EditProfile.dart';
import 'package:coller_mobile/view/MMMenu.dart';
import 'package:coller_mobile/view/CollageManagement/todolist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    CMMenu(),
    MMMenu(),
    EditProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.uid);
      uTodolist.userUid = auth.currentUser!.uid.toString();
      uNotes.userUid = auth.currentUser!.uid.toString();
      uTask.userUid = auth.currentUser!.uid.toString();
      uSchedule.userUid = auth.currentUser!.uid.toString();
      uIncome.userUid = auth.currentUser!.uid.toString();
      uOutcome.userUid = auth.currentUser!.uid.toString();
    }

    String emailku = auth.currentUser!.email.toString();

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 29),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello, " + emailku,
                                style: mainTitleTextStyle,
                              ),
                              Text(
                                "Make your life better with Coller!",
                                style: TextStyle(
                                    color: semiDarkGreyColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              )
                            ],
                          ),
                          InkWell(
                            child: Image.asset(
                              "assets/images/profile.png",
                              height: 45,
                              width: 45,
                            ),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => OverviewProfile()),
                              // );
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 38),
                      Stack(
                        children: [
                          Material(
                            child: TextField(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Notes()),
                                );
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                                hintText: "Add instant note in here ...",
                                fillColor: Color(0xffF3F3F3),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xffF3F3F3)),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Color(0xffF3F3F3)),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FloatingActionButton(
                              child: Icon(Icons.add),
                              backgroundColor: redColor,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Your Saldo.",
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 20),
                      // card
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage("assets/images/card.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Current Balance",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13),
                                  ),
                                  Image.asset(
                                    "assets/images/coller-white-logo.png",
                                    height: 31,
                                    width: 31,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rp. 2.385.000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24),
                                  ),
                                  Text(
                                    " ,-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Irene Bae / +1 2738 23** ***",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                  Text(
                                    "12/24",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Income
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: 85,
                                  decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_piggy.png",
                                          width: 51,
                                          height: 42,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Income",
                                              style: subMenuTextStyle,
                                            ),
                                            Text(
                                              "Rp. 3.000.000,-",
                                              style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Income()),
                                  // );
                                },
                              ),
                            ),
                            // Outcome
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                child: Container(
                                  height: 85,
                                  decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/ic_handCart.png",
                                          width: 61,
                                          height: 42,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Outcome",
                                              style: subMenuTextStyle,
                                            ),
                                            Text(
                                              "Rp. 615.000,-",
                                              style: TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontSize: 10),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => Outcome()),
                                  // );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "What you have to finish.",
                        style: titleTextStyle,
                      ),
                      SizedBox(height: 28),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  badgeColor: redColor,
                                  position:
                                      BadgePosition.topEnd(top: -15, end: -10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_books.png",
                                        width: 76,
                                        height: 30,
                                      ),
                                      SizedBox(height: 10),
                                      Text("Task", style: subMenuTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Task()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: Text(
                                      '5',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  badgeColor: redColor,
                                  position:
                                      BadgePosition.topEnd(top: -15, end: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_alarmClock.png",
                                        width: 41,
                                        height: 38,
                                      ),
                                      SizedBox(height: 10),
                                      Text("Schedule", style: subMenuTextStyle)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => schedule()),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: Text(
                                      '6',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  badgeColor: redColor,
                                  position:
                                      BadgePosition.topEnd(top: -15, end: -10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/ic_text.png",
                                        width: 33,
                                        height: 26,
                                      ),
                                      SizedBox(height: 10),
                                      Text("To do List",
                                          style: subMenuTextStyle)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Todolist()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
