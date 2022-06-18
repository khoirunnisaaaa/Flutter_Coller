import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/controller/DemoController.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../Profile/OverviewProfile.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final DemoController ctrl = Get.find();
  final TextEditingController _todos = TextEditingController();
  String? documentId;
  String? todosStatus;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        color: ctrl.isDark ? Color.fromARGB(255, 51, 50, 50) : Colors.white,
        padding: EdgeInsets.all(20),
        maxHeight: size.height,
        minHeight: size.height * 0.6,
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
                        'To do list',
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
                    height: 50,
                  ),
                  Text(
                    "New To do list.",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(height: 10.0),
                          //first element in the column is the white background (the Image.asset in your case)
                          Form(
                            key: _formKey,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: redColor),
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                              controller: _todos,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Type in here"),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Please fill this field.';
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                  width: 350.0,
                                  height: 50.0,
                                )),
                          )

                          //second item in the column is a transparent space of 20
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // Container(
                          //   width: 170.0,
                          // ),
                          Column(
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                  height: 65,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(0,
                                            10), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: redColor,
                                    ),
                                    // child: Text(
                                    //   "+",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       color: redColor,
                                    //       fontWeight: FontWeight.w500),
                                    // ),
                                  ),
                                ),
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (documentId == null) {
                                      await uTodolist.addItem(
                                          todos: _todos.text, status: "false");
                                      _todos.clear();
                                    } else {
                                      await uTodolist.updateItem(
                                          todos: _todos.text,
                                          status: todosStatus as String,
                                          docId: documentId as String);
                                      _todos.clear();
                                    }
                                    uTodolist.getLength();
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      ),
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
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: uTodolist.readItems(),
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
                              var todosInfo = streamSnapshot.data!.docs[index]
                                  .data() as Map<String, dynamic>;
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              String docId =
                                  streamSnapshot.data!.docs[index].id;
                              String todos = todosInfo['todos'];
                              String status = todosInfo['status'];
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
                                        _todos.text = todosInfo['todos'];
                                        documentId = docId;
                                        todosStatus = status;
                                      },
                                      backgroundColor:
                                          Color.fromARGB(255, 99, 185, 255),
                                      foregroundColor: Colors.white,
                                      icon: Icons.edit_rounded,
                                    ),
                                    SlidableAction(
                                      onPressed: ((context) async {
                                        await uTodolist.deleteItem(
                                            docId: docId);
                                        uTodolist.getLength();
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
                                          await uTodolist.updateItem(
                                              todos: todos,
                                              status: value.toString(),
                                              docId: docId);
                                          uTodolist.getLength();
                                        },
                                      ),
                                      title: Text(
                                        todos,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // subtitle: Text(
                                      //   'Membuat tutorial memasak.',
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      // trailing: Text(
                                      //   "10/06/2022",
                                      //   style: TextStyle(color: Color(0xff464646)),
                                      // ),
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
                  // StreamBuilder(
                  //           stream: uTodolist.readItems(),
                  //           builder: (context,
                  //               AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  //             if (streamSnapshot.hasError) {
                  //               return Text("Something went wrong");
                  //             } else if (streamSnapshot.hasData ||
                  //                 streamSnapshot.data != null) {
                  //               return ListView.separated(
                  //                   scrollDirection: Axis.vertical,
                  //                   shrinkWrap: true,
                  //                   separatorBuilder: (context, index) =>
                  //                       SizedBox(height: 15.0),
                  //                   itemCount: streamSnapshot.data!.docs.length,
                  //                   itemBuilder: (context, index) {
                  //                     var todosInfo = streamSnapshot
                  //                         .data!.docs[index]
                  //                         .data() as Map<String, dynamic>;
                  //                     final DocumentSnapshot documentSnapshot =
                  //                         streamSnapshot.data!.docs[index];
                  //                     String todos = todosInfo['todos'];
                  //                     String status = todosInfo['status'];
                  //                     bool bstatus = status == "true";
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void doEdit(BuildContext context) {}
void doDelete(BuildContext context) {}
