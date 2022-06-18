import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Profile/OverviewProfile.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  // DateTime _selectedDate = DateTime.now();

  final DemoController ctrl = Get.find();

  final initialdateval = TextEditingController();
  final deskTask = TextEditingController();
  final List<String> catItems = ['Quiz', 'Assignment'];

  String? _selectedCat;
  String? documentId;
  String? taskStatus;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uTask.getLength();
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
          minHeight: size.height * 0.3,
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
                          'Task',
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
                      "New Task.",
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
                                    padding: EdgeInsets.all(20.0),
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
                                          items: catItems
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
                                            //Do something when changing the item if you want.
                                          },
                                          onSaved: (value) {
                                            _selectedCat = value.toString();
                                          },
                                        ),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        TextFormField(
                                            controller: deskTask,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                                hintText: "Task"),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please fill this field.';
                                              }
                                            }),
                                        SizedBox(
                                          width: 200,
                                        ),
                                        TextFormField(
                                          controller: initialdateval,
                                          decoration: InputDecoration(
                                              focusColor: redColor,
                                              suffixIcon: Icon(
                                                  Icons.date_range_rounded),
                                              hintText: 'Date*'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please fill this field.';
                                            }
                                          },
                                          onTap: () {
                                            _selectDate();
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  width: 400.0,
                                  height: 280.0,
                                )),
                            //second item in the column is a transparent space of 20
                            Container(height: 20.0),
                          ],
                        ),
                        Column(children: <Widget>[
                          //first element in column is the transparent offset
                          Container(height: 260.0),
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
                                  await uTask
                                      .addItem(
                                          catTask: _selectedCat as String,
                                          task: deskTask.text,
                                          date: initialdateval.text,
                                          status: "false")
                                      .then((value) => uTask.getLength());
                                } else {
                                  await uTask
                                      .updateItem(
                                          docId: documentId as String,
                                          catTask: _selectedCat as String,
                                          task: deskTask.text,
                                          date: initialdateval.text,
                                          status: taskStatus as String)
                                      .then((value) => uTask.getLength());
                                }
                                deskTask.clear();
                                initialdateval.clear();
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
                    SizedBox(
                      height: 15,
                    ),
                    StreamBuilder(
                      stream: uTask.readItems(),
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
                                var taskInfo = streamSnapshot.data!.docs[index]
                                    .data() as Map<String, dynamic>;
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data!.docs[index];
                                String docId =
                                    streamSnapshot.data!.docs[index].id;
                                String taskCat = taskInfo['task_category'];
                                String task = taskInfo['task'];
                                String date = taskInfo['date'];
                                String status = taskInfo['status'];
                                bool bstatus = status == "true";

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
                                          _selectedCat = taskCat;
                                          deskTask.text = task;
                                          initialdateval.text = date;
                                          taskStatus = status;
                                        },
                                        backgroundColor:
                                            Color.fromARGB(255, 99, 185, 255),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit_rounded,
                                      ),
                                      SlidableAction(
                                        onPressed: ((context) async {
                                          await uTask
                                              .deleteItem(docId: docId)
                                              .then(
                                                  (value) => uTask.getLength());
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
                                        leading: Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: redColor,
                                          value: bstatus,
                                          onChanged: (bool? value) async {
                                            await uTask
                                                .updateItem(
                                                    docId: docId,
                                                    catTask: taskCat,
                                                    task: task,
                                                    date: date,
                                                    status: value.toString())
                                                .then((value) =>
                                                    uTask.getLength());
                                          },
                                        ),
                                        title: Text(
                                          taskCat,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          task,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Text(
                                          date,
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
                    // Slidable(
                    //   // Specify a key if the Slidable is dismissible.
                    //   key: const ValueKey(0),

                    //   // The end action pane is the one at the right or the bottom side.
                    //   endActionPane: const ActionPane(
                    //     motion: ScrollMotion(),
                    //     children: [
                    //       SlidableAction(
                    //         // An action can be bigger than the others.
                    //         onPressed: doEdit,
                    //         backgroundColor: Color.fromARGB(255, 99, 185, 255),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.edit_rounded,
                    //       ),
                    //       SlidableAction(
                    //         onPressed: doDelete,
                    //         backgroundColor: Color(0xffF76963),
                    //         foregroundColor: Colors.white,
                    //         icon: Icons.delete_rounded,
                    //       ),
                    //     ],
                    //   ),

                    //   // The child of the Slidable is what the user sees when the
                    //   // component is not dragged.
                    //   child: Column(
                    //     children: [
                    //       SizedBox(height: 15),
                    // ListTile(
                    //   leading: Checkbox(
                    //     checkColor: Colors.white,
                    //     value: true,
                    //     onChanged: null,
                    //   ),
                    //   title: Text(
                    //     'Assignment',
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   subtitle: Text(
                    //     'Membuat tutorial memasak.',
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   trailing: Text(
                    //     "10/06/2022",
                    //     style: TextStyle(color: Color(0xff464646)),
                    //   ),
                    // ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime? _selectedDate = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030));

    final DateFormat formatter = DateFormat('yMd');
    final String finalDate = formatter.format(_selectedDate as DateTime);

    if (_selectedDate != null) {
      setState(() {
        initialdateval.text = finalDate;
      });
    }
  }
}

void doEdit(BuildContext context) {}
void doDelete(BuildContext context) {}
