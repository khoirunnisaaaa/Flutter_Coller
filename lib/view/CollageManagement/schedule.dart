import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/schedule.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Profile/OverviewProfile.dart';

class schedule extends StatefulWidget {
  const schedule({Key? key}) : super(key: key);

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  final DemoController ctrl = Get.find();
  String? _selectedDay;
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  final _timeStartController = TextEditingController();
  final _timeEndController = TextEditingController();
  final _topicController = TextEditingController();

  String? documentId;
  String? dayNow;
  final List<String> dayItems = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dayNow = DateFormat('EEEE').format(date);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Form(
      key: _formKey,
      child: SlidingUpPanel(
        color: ctrl.isDark ? Color.fromARGB(255, 51, 50, 50) : Colors.white,
        padding: EdgeInsets.all(20),
        maxHeight: size.height,
        minHeight: size.height * 0.35,
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
              padding: EdgeInsets.all(30),
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
                                builder: (context) => navbar(index: 1)),
                          );
                        },
                      ),
                      Text(
                        'Schedule',
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
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "New Schedule.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          //first element in the column is the white background (the Image.asset in your case)
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: redColor),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
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
                                            'Day*',
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
                                          items: dayItems
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
                                              return 'Please select income category.';
                                            }
                                          },
                                          onChanged: (value) {
                                            uSchedule.hari = value.toString();
                                          },
                                          onSaved: (value) {
                                            _selectedDay = value.toString();
                                          },
                                        ),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        TextFormField(
                                            controller: _topicController,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                hintText: "Topic*"),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please fill this field.';
                                              }
                                            }),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        TextFormField(
                                          controller: _timeStartController,
                                          decoration: InputDecoration(
                                              focusColor: redColor,
                                              suffixIcon:
                                                  Icon(Icons.access_time_sharp),
                                              hintText: 'Time Start*'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please fill this field.';
                                            }
                                          },
                                          onTap: () {
                                            selectTimeStart();
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        TextFormField(
                                          controller: _timeEndController,
                                          decoration: InputDecoration(
                                              focusColor: redColor,
                                              suffixIcon:
                                                  Icon(Icons.access_time_sharp),
                                              hintText: 'Time End*'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please fill this field.';
                                            }
                                          },
                                          onTap: () {
                                            selectTimeEnd();
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                        SizedBox(
                                          width: 200,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                width: 400.0,
                                height: 250.0,
                              )),
                          //second item in the column is a transparent space of 20
                          Container(height: 20.0),
                        ],
                      ),
                      Column(children: <Widget>[
                        //first element in column is the transparent offset
                        Container(height: 225.0),
                        Center(
                            child: InkWell(
                          child: Container(
                            height: 50,
                            width: 140,
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

                              if (documentId == null) {
                                await uSchedule.addItem(
                                    day: _selectedDay as String,
                                    topic: _topicController.text,
                                    timeStart: _timeStartController.text,
                                    timeEnd: _timeEndController.text);

                                _topicController.clear();
                                _timeStartController.clear();
                                _timeEndController.clear();
                              } else {
                                await uSchedule.updateItem(
                                    docId: documentId as String,
                                    day: _selectedDay as String,
                                    topic: _topicController.text,
                                    timeStart: _timeStartController.text,
                                    timeEnd: _timeEndController.text);
                              }
                              uSchedule.getLength();
                            }
                          },
                        ))
                      ])
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        panel: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 170),
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
                  SizedBox(
                    height: 35,
                  ),
                  Column(children: <Widget>[
                    Center(
                        child: InkWell(
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            dayNow.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onTap: () {
                        showAlertDialog();
                      },
                    ))
                  ]),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Column(
                        children: <Widget>[
                          Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(120),
                              1: FlexColumnWidth()
                            },
                            children: <TableRow>[
                              TableRow(children: <Widget>[
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Topic',
                                  style: TextStyle(
                                    color: redColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          StreamBuilder(
                            stream: uSchedule.readItems(dayNow.toString()),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (streamSnapshot.hasError) {
                                return Text("Something went wrong");
                              } else if (streamSnapshot.hasData ||
                                  streamSnapshot.data != null) {
                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: streamSnapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var scheduleInfo = streamSnapshot
                                          .data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      final DocumentSnapshot documentSnapshot =
                                          streamSnapshot.data!.docs[index];
                                      String docId =
                                          streamSnapshot.data!.docs[index].id;
                                      String day = scheduleInfo['day'];
                                      String topic = scheduleInfo['topic'];
                                      String timeStart =
                                          scheduleInfo['timestart'];
                                      String timeEnd = scheduleInfo['timeend'];

                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Slidable(
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
                                                  _topicController.text = topic;
                                                  _timeStartController.text =
                                                      timeStart;
                                                  _timeEndController.text =
                                                      timeEnd;
                                                },
                                                backgroundColor: Color.fromARGB(
                                                    255, 99, 185, 255),
                                                foregroundColor: Colors.white,
                                                icon: Icons.edit_rounded,
                                              ),
                                              SlidableAction(
                                                onPressed: ((context) async {
                                                  await uSchedule.deleteItem(
                                                      docId: docId);
                                                  uSchedule.getLength();
                                                }),
                                                backgroundColor:
                                                    Color(0xffF76963),
                                                foregroundColor: Colors.white,
                                                icon: Icons.delete_rounded,
                                              ),
                                            ],
                                          ),
                                          child: Table(
                                            columnWidths: const <int,
                                                TableColumnWidth>{
                                              0: FixedColumnWidth(120),
                                              1: FlexColumnWidth()
                                            },
                                            children: <TableRow>[
                                              TableRow(children: <Widget>[
                                                Text(
                                                  '${timeStart} - ${timeEnd}',
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  topic,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ])
                                            ],
                                          ),
                                          // The child of the Slidable is what the user sees when the
                                          // component is not dragged.
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
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Future selectTimeStart() async {
    TimeOfDay? _selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_selectedTime != null) {
      setState(() {
        time = _selectedTime;
        final hours = time.hour.toString().padLeft(2, '0');
        final minutes = time.minute.toString().padLeft(2, '0');
        _timeStartController.text = "${hours}:${minutes}";
        // _timeEndController.text = "${hours}:${minutes}";
      });
    }
  }

  Future selectTimeEnd() async {
    TimeOfDay? _selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (_selectedTime != null) {
      setState(() {
        time = _selectedTime;
        final hours = time.hour.toString().padLeft(2, '0');
        final minutes = time.minute.toString().padLeft(2, '0');
        // _timeStartController.text = "${hours}:${minutes}";
        _timeEndController.text = "${hours}:${minutes}";
      });
    }
  }

  showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Day'),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dayItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(dayItems[index]),
                    onTap: () {
                      setState(() {
                        dayNow = dayItems[index];
                      });
                      Navigator.pop(context, dayItems[index]);
                    },
                  );
                },
              ),
            ),
          );
        });
  }
}

void doEdit(BuildContext context) {}
void doDelete(BuildContext context) {}
