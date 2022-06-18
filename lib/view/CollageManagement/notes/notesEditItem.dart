import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/notes.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/view/CollageManagement/notes/notes.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class notesEditItem extends StatefulWidget {
  final String? documentId;
  final String? docTitle;
  final String? docBody;

  const notesEditItem(
      {required this.documentId,
      required this.docTitle,
      required this.docBody});

  @override
  State<notesEditItem> createState() => _notesEditItemState();
}

class _notesEditItemState extends State<notesEditItem> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _titleController = TextEditingController(text: widget.docTitle);
    _bodyController = TextEditingController(text: widget.docBody);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final now = new DateTime.now();
    String formatter = DateFormat('yMd').format(now);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
      padding: EdgeInsets.only(top: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Container(
                    width: 40,
                    height: 40,
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
                      MaterialPageRoute(builder: (context) => Notes()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Edit Notes.",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(children: [
                DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: redColor),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                            controller: _titleController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Title"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please fill this field!';
                              }
                              return null;
                            }),
                      ),
                      width: 350.0,
                      height: 60.0,
                    )),
                SizedBox(
                  height: 20,
                ),
                DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: redColor),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextFormField(
                              maxLines: null,
                              minLines: 15,
                              // expands: true,
                              controller: _bodyController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  hintText: "body", border: InputBorder.none),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please fill this field';
                                }
                                return null;
                              }),
                        ),
                      ),
                      width: 350.0,
                      height: 400.0,
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: InkWell(
                  child: Container(
                    height: 40,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16,
                            color: redColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await uNotes.updateItem(
                          docId: widget.documentId as String,
                          title: _titleController.text,
                          body: _bodyController.text,
                          date: formatter);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Notes()),
                      );
                    }
                  },
                ))
              ]),
            ),
            // Stack(
            //   children: <Widget>[
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Container(height: 10.0),
            //         //first element in the column is the white background (the Image.asset in your case)
            //         DecoratedBox(
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(30.0),
            //                 color: redColor),
            //             child: Container(
            //               child: Padding(
            //                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            //                 child: Column(
            //                   children: [
            //                     TextField(
            //                       keyboardType: TextInputType.text,
            //                       decoration: InputDecoration(
            //                           hintText: "Type in here"),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               width: 350.0,
            //               height: 50.0,
            //             )),
            //         //second item in the column is a transparent space of 20
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: <Widget>[
            //         // Container(
            //         //   width: 170.0,
            //         // ),
            //         Column(
            //           children: <Widget>[
            //             InkWell(
            //               child: Container(
            //                 height: 65,
            //                 width: 65,
            //                 decoration: BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.circular(50),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: Colors.black.withOpacity(0.1),
            //                       spreadRadius: 0,
            //                       blurRadius: 10,
            //                       offset: Offset(
            //                           0, 10), // changes position of shadow
            //                     ),
            //                   ],
            //                 ),
            //                 child: Center(
            //                   child: Icon(
            //                     Icons.add,
            //                     size: 30,
            //                     color: redColor,
            //                   ),
            //                   // child: Text(
            //                   //   "+",
            //                   //   style: TextStyle(
            //                   //       fontSize: 16,
            //                   //       color: redColor,
            //                   //       fontWeight: FontWeight.w500),
            //                   // ),
            //                 ),
            //               ),
            //               onTap: () {
            //                 // Navigator.push(
            //                 //   context,
            //                 //   MaterialPageRoute(
            //                 //       builder: (context) => EditProfile()),
            //                 // );
            //               },
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    ))));
  }
}
