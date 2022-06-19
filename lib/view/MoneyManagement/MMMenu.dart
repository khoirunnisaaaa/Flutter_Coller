import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/view/MoneyManagement/Income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'Outcome.dart';

class MMMenu extends StatefulWidget {
  const MMMenu({Key? key}) : super(key: key);

  @override
  State<MMMenu> createState() => _MMMenuState();
}

class _MMMenuState extends State<MMMenu> {
  final DemoController ctrl = Get.find();
  DateTime _selectedDate = DateTime.now();
  final initialdateval = TextEditingController();
  String balance = ((uIncome.totalIncome) - (uOutcome.totalOutcome)).toString();
  String totalIncome = (uIncome.totalIncome).toString();
  String totalOutcome = (uOutcome.totalOutcome).toString();
  int sum = 0;

  @override
  void initState() {
    super.initState();
    uIncome.totalIncome = 0;
    uOutcome.totalOutcome = 0;
    uIncome.getNama();
    uOutcome.getNama();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: ctrl.isDark
                    ? AssetImage('assets/images/bg_mmmenu2.png')
                    : AssetImage('assets/images/bg_mmmenu.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  Text(
                    'Money Management',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 28),
                  ),
                  Text(
                    'Track of Your Transactions',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  SizedBox(height: 45),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 15,
                          offset: Offset(1.9, 9), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                      child: Column(
                        children: [
                          Text(
                            'Balance',
                            style: TextStyle(
                                fontSize: 16, color: Color(0xff9F9F9F)),
                          ),
                          // TextFormField(
                          //   textAlign: TextAlign.center,
                          //   controller: initialdateval,
                          //   onTap: () {
                          //     _selectDate();
                          //     FocusScope.of(context)
                          //         .requestFocus(new FocusNode());
                          //   },
                          //   decoration: InputDecoration(
                          //       border: InputBorder.none,
                          //       hintText:
                          //           '${DateFormat().add_yMMMM().format(DateTime.now())}'),
                          // ),
                          // Divider(
                          //   color: Color(0xffEBEBEB),
                          // ),
                          SizedBox(height: 15),
                          Text(
                            'Rp. ${balance}',
                            style: TextStyle(
                                color: darkGreyColor,
                                fontSize: 27,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                          color: Color(0xff9F9F9F),
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'Rp. ${totalIncome}',
                                      style: TextStyle(
                                          color: darkGreyColor, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Outcome',
                                    style: TextStyle(
                                        color: Color(0xff9F9F9F), fontSize: 13),
                                  ),
                                  Text(
                                    'Rp. ${totalOutcome}',
                                    style: TextStyle(
                                        color: darkGreyColor, fontSize: 16),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 88,
                          height: 1,
                          decoration: BoxDecoration(color: Color(0xffC7C7C7)),
                        ),
                        Text(
                          'Menu.',
                          style: TextStyle(
                              color: Color(0xff9F9F9F),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: 88,
                          height: 1,
                          decoration: BoxDecoration(color: Color(0xffC7C7C7)),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.attach_money_rounded,
                                color: redColor,
                                size: 40,
                              ),
                            ),
                            SizedBox(width: 25),
                            Text(
                              'Income',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Income()),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(22)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.local_mall_rounded,
                                color: redColor,
                                size: 40,
                              ),
                            ),
                            SizedBox(width: 25),
                            Text(
                              'Outcome',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Outcome()),
                      );
                    },
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future _selectDate() async {
    DateTime? _selectedDate = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime.now());

    if (_selectedDate != null) {
      setState(() {
        initialdateval.text = _selectedDate.toString();
      });
    }
  }
}
