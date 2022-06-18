import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/view/Profile/OverviewProfile.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:get/get.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Center(
                child: Text(
                  'About Applications.',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'College Lifestyle Helper is a platform that was built with the main goal of making it easier for students to live their college life. With today\'s technological advances, gadgets such as laptops, cellphones, tablets are rarely out of reach of young people, especially students. This of course also affects their habits when taking classes in lectures. Activities such as recording schedules, making short notes, making to do lists or lists of things to be done, also taking notes on assignments and even quiz schedules are things that students often do. \n\nTherefore, with the fact that gadgets are always near students, as well as various activities such as recording schedules and others, we built a platform that can meet these needs. Where students can record their schedule without fear of negligence, make short notes that will be very helpful if in the middle of lectures it is needed to record important things urgently, record any assignments that are obtained and quiz schedules so as not to be missed. In addition, to support productivity, College Lifestyle Helper provides a to do list feature where users can record what things will be done in a full day. \n\nIn addition, in college life, students often pay less attention to their finances. Not keeping track of financial flows that end up not realizing how extravagant their expenses are. Therefore, we are here to solve this problem. With our feature, namely "Money Management", users can easily find out all their financial transactions.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
