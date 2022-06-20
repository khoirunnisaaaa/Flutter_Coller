import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/main.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/view/MoneyManagement/MMMenu.dart';
import 'package:coller_mobile/view/MoneyManagement/Outcome.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../theme.dart';
import '../Profile/OverviewProfile.dart';
import '../indicator.dart';

class Outcome extends StatefulWidget {
  const Outcome({Key? key}) : super(key: key);

  @override
  State<Outcome> createState() => _OutcomeState();
}

class _OutcomeState extends State<Outcome> {
  int touchedIndex = -1;
  final DemoController ctrl = Get.find();
  double sum = 0.0;

  final List<String> outcomeItems = [
    'Food',
    'Education',
    'Entertainment',
    '.etc'
  ];
  String? selectedCategory;
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();
  // final initialdateval = TextEditingController();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _outcome = TextEditingController();
  String? documentId;

  // operasi chart
  double? totalFood;
  double? totalEducation;
  double? totalEntertainment;
  double? totalEtc;

  @override
  void initState() {
    uOutcome.getNama();
    totalFood = uOutcome.totalFood;
    totalEducation = uOutcome.totalEducation;
    totalEntertainment = uOutcome.totalEntertainment;
    totalEtc = uOutcome.totalEtc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        color: ctrl.isDark ? Color.fromARGB(255, 51, 50, 50) : Colors.white,
        padding: EdgeInsets.all(20),
        maxHeight: size.height,
        minHeight: size.height * 0.2,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg-welcome-screen2.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 30,
                            color: redColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => navbar(index: 2)),
                          );
                        },
                      ),
                      Text(
                        'Outcome',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'New Outcome.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  Stack(
                    children: <Widget>[
                      //First thing in the stack is the background
                      //For the backgroud i create a column
                      Column(
                        children: <Widget>[
                          //first element in the column is the white background (the Image.asset in your case)
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: redColor),
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        right: 20,
                                        bottom: 40,
                                        left: 20),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _title,
                                          keyboardType: TextInputType.text,
                                          style: TextStyle(color: Colors.white),
                                          decoration: InputDecoration(
                                            labelText: 'Title *',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Title must be filled';
                                            }
                                            return null;
                                          },
                                        ),
                                        DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                            //Add isDense true and zero Padding.
                                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                            //Add more decoration as you want here
                                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                          ),
                                          isExpanded: true,
                                          hint: const Text(
                                            'Category*',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.black45,
                                          ),
                                          iconSize: 30,
                                          buttonHeight: 60,
                                          buttonPadding: const EdgeInsets.only(
                                              left: 0, right: 10),
                                          dropdownDecoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          items: outcomeItems
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select outcome category.';
                                            }
                                          },
                                          onChanged: (value) {
                                            //Do something when changing the item if you want.
                                            selectedCategory = value.toString();
                                          },
                                          onSaved: (value) {
                                            selectedCategory = value.toString();
                                          },
                                        ),
                                        TextFormField(
                                          // controller: _date
                                          controller: _date,
                                          onTap: () {
                                            _selectDate();
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                          decoration: InputDecoration(
                                              focusColor: redColor,
                                              suffixIcon: Icon(
                                                  Icons.date_range_rounded),
                                              hintText: 'Date*'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Date must be filled';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          controller: _outcome,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Outcome(Rp.) *',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Outcome must be filled';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                          //second item in the column is a transparent space of 20
                          Container(height: 30.0),
                        ],
                      ),
                      //for the button i create another column

                      //first element in column is the transparent offset
                      Positioned(
                        bottom: 0.0,
                        left: 50,
                        child: InkWell(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Add New",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: redColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                            String category = selectedCategory as String;
                            print("documentId: ${documentId}");
                            if (documentId != null) {
                              await uOutcome.updateItem(
                                  title: _title.text,
                                  category: category,
                                  date: _date.text,
                                  outcome: int.parse(_outcome.text),
                                  docId: documentId as String);
                              _title.clear();
                              _date.clear();
                              _outcome.clear();
                            } else {
                              await uOutcome.addItem(
                                title: _title.text,
                                category: category,
                                date: _date.text,
                                outcome: int.parse(_outcome.text),
                              );
                              _title.clear();
                              _date.clear();
                              _outcome.clear();
                            }

                            await uOutcome.getNama();
                            setState(() {
                              totalFood = uOutcome.totalFood;
                              totalEducation = uOutcome.totalEducation;
                              totalEntertainment = uOutcome.totalEntertainment;
                              totalEtc = uOutcome.totalEtc;
                            });
                          },
                          // onTap: () {
                          //   if (_formKey.currentState!.validate()) {
                          //     _formKey.currentState!.save();
                          //     print(selectedCategory);
                          //   }
                          // },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        panel: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 30, bottom: 170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 53,
                      height: 2,
                      decoration: BoxDecoration(color: Color(0xffC4C4C4)),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Chart & History',
                      style: titleFeatureTextStyle,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Chart % Outcome.',
                    style: ctrl.isDark
                        ? TextStyle(
                            color: Color(0xffA7A7A7),
                            fontWeight: FontWeight.w600,
                            fontSize: 16)
                        : titleTextStyle,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFCE3DF).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22)),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    setState(() {
                                      if (!event.isInterestedForInteractions ||
                                          pieTouchResponse == null ||
                                          pieTouchResponse.touchedSection ==
                                              null) {
                                        touchedIndex = -1;
                                        return;
                                      }
                                      touchedIndex = pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections()),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Indicator(
                              color: Color(0xff9F43CC),
                              text: 'Food',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xff4D4D4E),
                              text: 'Entertainment',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xffFF57BC),
                              text: 'Education',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xffFB4F4F),
                              text: '.etc',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                      ],
                    ),
                  ),
                  // Image.asset("assets/images/pie_chart.png"),
                  SizedBox(height: 30),
                  Text(
                    'History Outcome.',
                    style: ctrl.isDark
                        ? TextStyle(
                            color: Color(0xffA7A7A7),
                            fontWeight: FontWeight.w600,
                            fontSize: 16)
                        : titleTextStyle,
                  ),
                  // SizedBox(height: 20),
                  // Text(
                  //   "16/05/2022",
                  //   style: dateMMTextStyle,
                  // ),
                  // SLIDE-ABLE
                  StreamBuilder(
                    stream: uOutcome.readItems(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasError) {
                        return Text("Something went wrong");
                      } else if (streamSnapshot.hasData ||
                          streamSnapshot.data != null) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var outcomesInfo =
                                  streamSnapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              String docId =
                                  streamSnapshot.data!.docs[index].id;
                              String title = outcomesInfo['title'];
                              String category = outcomesInfo['category'];
                              int outcome = outcomesInfo['outcome'];
                              String date = outcomesInfo['date'];

                              return Slidable(
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(0),

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      onPressed: (context) {
                                        documentId = docId;
                                        _title.text = outcomesInfo['title'];
                                        _date.text = outcomesInfo['date'];
                                        selectedCategory =
                                            outcomesInfo['category'];
                                        _outcome.text =
                                            outcomesInfo['outcome'].toString();
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 99, 185, 255),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                    ),
                                    SlidableAction(
                                      onPressed: ((context) async {
                                        await uOutcome.deleteItem(docId: docId);
                                        await uOutcome.getNama();
                                        setState(() {
                                          totalFood = uOutcome.totalFood;
                                          totalEducation =
                                              uOutcome.totalEducation;
                                          totalEntertainment =
                                              uOutcome.totalEntertainment;
                                          totalEtc = uOutcome.totalEtc;
                                        });
                                      }),
                                      backgroundColor: Color(0xffF76963),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete_rounded,
                                    ),
                                  ],
                                ),

                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: Column(
                                  children: [
                                    SizedBox(height: 15),
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: redColor,
                                        child: category == 'Food'
                                            ? Icon(
                                                Icons.restaurant_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              )
                                            : category == 'Entertainment'
                                                ? Icon(
                                                    Icons
                                                        .sports_esports_rounded,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )
                                                : category == 'Beauty'
                                                    ? Icon(
                                                        Icons.woman_rounded,
                                                        color: Colors.white,
                                                        size: 20,
                                                      )
                                                    : category == 'Education'
                                                        ? Icon(
                                                            Icons
                                                                .cast_for_education_rounded,
                                                            color: Colors.white,
                                                            size: 20,
                                                          )
                                                        : category == 'Social'
                                                            ? Icon(
                                                                Icons
                                                                    .groups_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 20,
                                                              )
                                                            : category ==
                                                                    'Travel'
                                                                ? Icon(
                                                                    Icons
                                                                        .flight_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .more_horiz_rounded,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 20,
                                                                  ),
                                      ),
                                      title: Text(
                                        title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(date),
                                      trailing: Text(
                                        "Rp. ${outcome}",
                                        style: ctrl.isDark
                                            ? TextStyle(
                                                color: Color(0xffA7A7A7),
                                                fontSize: 13)
                                            : TextStyle(
                                                color: Color(0xff464646),
                                                fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff9F43CC),
            value: totalFood,
            title: '${(uOutcome.persenFood).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff4D4D4E),
            value: totalEducation,
            title: '${(uOutcome.persenEducation).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffFF57BC),
            value: totalEntertainment,
            title: '${(uOutcome.persenEntertainment).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xffFB4F4F),
            value: totalEtc,
            title: '${(uOutcome.persenEtc).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  Future _selectDate() async {
    DateTime? _selectedDate = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime.now());

    final DateFormat formatter = DateFormat('yMd');
    final String finalDate = formatter.format(_selectedDate as DateTime);
    if (_selectedDate != null) {
      setState(() {
        _date.text = finalDate.toString();
      });
    }
  }
}

void doEdit(BuildContext context) {}
void doDelete(BuildContext context) {}
