import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/CollageManagement/schedule.dart';
import 'package:coller_mobile/view/CollageManagement/task.dart';
import 'package:coller_mobile/view/CollageManagement/todolist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme.dart';
import '../Profile/OverviewProfile.dart';

class CMMenu extends StatefulWidget {
  @override
  State<CMMenu> createState() => _CMMenuState();
}

class _CMMenuState extends State<CMMenu> {
  var currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
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
                    Text("College Management.", style: mainTitleTextStyle),
                    InkWell(
                      child: Image.asset(
                        "assets/images/profile.png",
                        height: 45,
                        width: 45,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OverviewProfile()),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(height: 70),
                Text(
                  "Menu.",
                  style: TextStyle(
                      color: Color(0xff9F9F9F),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(11)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/ic_pen.png",
                                  height: 63),
                              SizedBox(height: 15),
                              Text("Notes", style: titleTextStyle),
                              Text(
                                "Catatan Penting",
                                style: TextStyle(
                                  color: Color(0xffA7A7A7),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Notes()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(11)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/ic_books.png",
                                  height: 53),
                              SizedBox(height: 15),
                              Text("Task", style: titleTextStyle),
                              Text(
                                "Daftar Tugas, Quis",
                                style: TextStyle(
                                  color: Color(0xffA7A7A7),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Task()),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(11)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/ic_alarmClock.png",
                                  height: 65),
                              SizedBox(height: 15),
                              Text("Schedule", style: titleTextStyle),
                              Text(
                                "Jadwal hari ini",
                                style: TextStyle(
                                  color: Color(0xffA7A7A7),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => schedule()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(11)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/ic_text.png",
                                  height: 54),
                              SizedBox(height: 15),
                              Text("To do List", style: titleTextStyle),
                              Text(
                                "Yang harus dilakukan",
                                style: TextStyle(
                                  color: Color(0xffA7A7A7),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Todolist()),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
