import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/notes.dart';
import 'package:coller_mobile/utils/CollageManagement/schedule.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/CollageManagement/CMMenu.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notesAddItem.dart';
import 'package:coller_mobile/view/CollageManagement/schedule.dart';
import 'package:coller_mobile/view/CollageManagement/task.dart';
import 'package:coller_mobile/view/MoneyManagement/Income.dart';
import 'package:coller_mobile/view/MoneyManagement/MMMenu.dart';
import 'package:coller_mobile/view/CollageManagement/todolist.dart';
import 'package:coller_mobile/view/MoneyManagement/Outcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/DemoController.dart';
import 'Profile/EditProfile.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? nama;
  String? profImg;
  int? taskCounter;
  int? scheduleCounter;
  int? todosCounter;
  String? dayNow;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DemoController ctrl = Get.find();
    dayNow = DateFormat('EEEE').format(date);
    String balance =
        ((uIncome.totalIncome) - (uOutcome.totalOutcome)).toString();
    String totalIncome = (uIncome.totalIncome).toString();
    String totalOutcome = (uOutcome.totalOutcome).toString();

    // @override
    // void initState() {
    //   _getMmData();
    //   // TODO: implement initState
    //   super.initState();
    // }

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
                              uProfile.nama_lengkap != null
                                  ? Text(
                                      "Hello, " +
                                          uProfile.nama_lengkap.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ))
                                  : FutureBuilder(
                                      future: _getProfileData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text("Hello, ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ));
                                        } else {
                                          return Text(
                                              "Hello, " + nama.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ));
                                        }
                                      },
                                    ),
                              Text(
                                "Make your life better with Coller!",
                                style: TextStyle(
                                    color: Color(0xff949494),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13),
                              )
                            ],
                          ),
                          uProfile.prof_img != null
                              ? CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(uProfile
                                      .prof_img
                                      .toString()), // for Network image
                                )
                              : FutureBuilder(
                                  future: _getProfileData(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState !=
                                        ConnectionState.done) {
                                      return CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: redColor,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ), // for Network image
                                      );
                                    } else {
                                      return CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(profImg
                                            .toString()), // for Network image
                                      );
                                    }
                                  },
                                ),
                          // InkWell(
                          //   child: Image.asset(
                          //     "assets/images/profile.png",
                          //     height: 45,
                          //     width: 45,
                          //   ),
                          //   onTap: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //       builder: (context) => OverviewProfile()),
                          //     // );
                          //   },
                          // )
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
                                      builder: (context) => notesAddItem()),
                                );
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                // hintStyle: TextStyle(color: Color(0xffA7A7A7)),
                                hintText: "Add instant note in here ...",
                                // fillColor: Color(0xffF3F3F3),
                                focusedBorder: OutlineInputBorder(
                                  // borderSide:
                                  //     new BorderSide(color: Color(0xffF3F3F3)),
                                  borderRadius: new BorderRadius.circular(25.7),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.transparent),
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => notesAddItem()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Your Saldo.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
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
                              FutureBuilder(
                                future: uIncome.getNama(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState !=
                                      ConnectionState.done) {
                                    return Row(
                                      children: [
                                        Text(
                                          "Rp. -",
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
                                    );
                                  } else {
                                    return Row(
                                      children: [
                                        Text(
                                          "Rp. ${uIncome.totalIncome - uOutcome.totalOutcome}",
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
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 50),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  uProfile.nama_lengkap != null
                                      ? Text(
                                          uProfile.nama_lengkap.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11),
                                        )
                                      : FutureBuilder(
                                          future: _getProfileData(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState !=
                                                ConnectionState.done) {
                                              return Text(
                                                "...",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11),
                                              );
                                            } else {
                                              return Text(
                                                nama.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11),
                                              );
                                            }
                                          },
                                        ),
                                  Text(
                                    "coller",
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
                                      color: ctrl.isDark
                                          ? Color.fromARGB(31, 206, 206, 206)
                                          : greyColor,
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
                                            Text("Income",
                                                style: ctrl.isDark
                                                    ? TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13)
                                                    : subMenuTextStyle),
                                            FutureBuilder(
                                              future: uIncome.getNama(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState !=
                                                    ConnectionState.done) {
                                                  return Text(
                                                    "Rp. 0,-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontSize: 10),
                                                  );
                                                } else {
                                                  return Text(
                                                    "Rp. ${uIncome.totalIncome.toString()},-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontSize: 10),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Income()),
                                  ).then((value) {
                                    setState(() {});
                                  });
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
                                    color: ctrl.isDark
                                        ? Color.fromARGB(31, 206, 206, 206)
                                        : greyColor,
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
                                              style: ctrl.isDark
                                                  ? TextStyle(
                                                      color: Color(0xffA7A7A7),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13)
                                                  : subMenuTextStyle,
                                            ),
                                            FutureBuilder(
                                              future: uOutcome.getNama(),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState !=
                                                    ConnectionState.done) {
                                                  return Text(
                                                    "Rp. 0,-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontSize: 10),
                                                  );
                                                } else {
                                                  return Text(
                                                    "Rp. ${uOutcome.totalOutcome.toString()},-",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffA7A7A7),
                                                        fontSize: 10),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Outcome()),
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "What you have to finish.",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
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
                                    color: ctrl.isDark
                                        ? Color.fromARGB(31, 206, 206, 206)
                                        : greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: FutureBuilder(
                                      future: _getCmData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return Text(
                                            taskCounter.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      },
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
                                      Text("Task",
                                          style: ctrl.isDark
                                              ? TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)
                                              : subMenuTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Task()),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: ctrl.isDark
                                        ? Color.fromARGB(31, 206, 206, 206)
                                        : greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: FutureBuilder(
                                      future: _getCmData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return Text(
                                            scheduleCounter.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      },
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
                                      Text("Schedule",
                                          style: ctrl.isDark
                                              ? TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)
                                              : subMenuTextStyle)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => schedule()),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    color: ctrl.isDark
                                        ? Color.fromARGB(31, 206, 206, 206)
                                        : greyColor,
                                    borderRadius: BorderRadius.circular(11)),
                                child: Badge(
                                  badgeContent: Container(
                                    width: 25,
                                    height: 25,
                                    child: FutureBuilder(
                                      future: _getCmData(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "0",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        } else {
                                          return Text(
                                            todosCounter.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          );
                                        }
                                      },
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
                                          style: ctrl.isDark
                                              ? TextStyle(
                                                  color: Color(0xffA7A7A7),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 13)
                                              : subMenuTextStyle)
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Todolist()),
                                ).then((value) {
                                  setState(() {});
                                });
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

  _getProfileData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        nama = (value.data()!["nama_lengkap"]).toString();
        profImg = (value.data()!["prof_img"]).toString();
        print("Nama : " + (value.data()!["nama_lengkap"]).toString());
        // print("Nama : " + (value.data()!["prof_img"]).toString());
      });
    }

    uProfile.getUserDoc();
    // uProfile.getUserDoc();
    //       uTask.getLength();
    //       uSchedule.getLength();
    //       uTodolist.getLength();
    uIncome.getNama();
    uOutcome.getNama();
  }

  _getCmData() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("task")
          .doc(firebaseUser.uid)
          .collection("items")
          .where("status", isEqualTo: "false")
          .get()
          .then((value) {
        taskCounter = value.docs.length;
        print("Task Length : " + value.docs.length.toString());
      });

      await FirebaseFirestore.instance
          .collection("todolist")
          .doc(firebaseUser.uid)
          .collection("items")
          .where("status", isEqualTo: "false")
          .get()
          .then((value) {
        todosCounter = value.docs.length;
        print("Todos Length : " + value.docs.length.toString());
      });

      await FirebaseFirestore.instance
          .collection("schedule")
          .doc(firebaseUser.uid)
          .collection("items")
          .where("day", isEqualTo: dayNow)
          .get()
          .then((value) {
        scheduleCounter = value.docs.length;
        print("Today : " +
            dayNow.toString() +
            " Length : " +
            value.docs.length.toString());
      });
    }
  }
}
