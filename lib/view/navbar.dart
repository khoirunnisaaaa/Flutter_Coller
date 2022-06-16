import 'dart:ui';

import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/view/CollageManagement/CMMenu.dart';
import 'package:coller_mobile/view/Dashboard.dart';
import 'package:coller_mobile/view/MoneyManagement/MMMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';

import 'Profile/OverviewProfile.dart';

class navbar extends StatefulWidget {
  final int? index;
  const navbar({required this.index});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _currentIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    CMMenu(),
    MMMenu(),
    OverviewProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _currentIndex = widget.index as int;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        height: screenWidth * .155,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [strongRedColor, Color(0xffF37970)]),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
                HapticFeedback.lightImpact();
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                SizedBox(
                  width: screenWidth * .2125,
                  height: screenWidth * .3000,
                  child: Center(
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: index == _currentIndex ? screenWidth * .12 : 0,
                      width: index == _currentIndex ? screenWidth * .2125 : 0,
                      decoration: BoxDecoration(
                        color: index == _currentIndex
                            ? Colors.white
                            : Color(0xffFDE1E0),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenWidth * .2125,
                  alignment: Alignment.center,
                  child: Icon(
                    listOfIcons[index],
                    size: screenWidth * .076,
                    color: index == _currentIndex
                        ? strongRedColor
                        : Color(0xffFDE1E0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.school_rounded,
    Icons.monetization_on_rounded,
    Icons.person_rounded,
  ];
}
