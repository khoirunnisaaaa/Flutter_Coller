// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coller_mobile/theme.dart';
// import 'package:coller_mobile/utils/CollageManagement/notes.dart';
// import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
// import 'package:coller_mobile/view/navbar.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// import '../../Profile/OverviewProfile.dart';

// class notesItem extends StatefulWidget {
//   const notesItem({Key? key}) : super(key: key);

//   @override
//   State<notesItem> createState() => _notesItemState();
// }

// class _notesItemState extends State<notesItem> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _bodyController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final now = new DateTime.now();
//     String formatter = DateFormat('yMd').format(now);
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(top: 20),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/bg-welcome-screen2.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Icon(
//                         Icons.chevron_left_rounded,
//                         size: 30,
//                         color: redColor,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => navbar()),
//                       );
//                     },
//                   ),
//                   InkWell(
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Icon(
//                         Icons.delete,
//                         size: 30,
//                         color: redColor,
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => OverviewProfile()),
//                       );
//                     },
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Text(
//                 "New Notes.",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               DecoratedBox(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                       color: redColor),
//                   child: Container(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _titleController,
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(hintText: "Title"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     width: 350.0,
//                     height: 60.0,
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               DecoratedBox(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15.0),
//                       color: redColor),
//                   child: Container(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//                       child: Column(
//                         children: [
//                           TextField(
//                             controller: _bodyController,
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration(hintText: "body"),
//                           ),
//                         ],
//                       ),
//                     ),
//                     width: 350.0,
//                     height: 400.0,
//                   )),
//               SizedBox(
//                 height: 20,
//               ),
//               Center(
//                   child: InkWell(
//                 child: Container(
//                   height: 40,
//                   width: 140,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         spreadRadius: 0,
//                         blurRadius: 10,
//                         offset: Offset(0, 10), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Save",
//                       style: TextStyle(
//                           fontSize: 16,
//                           color: redColor,
//                           fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ),
//                 onTap: () async {
//                   await uNotes.addItem(
//                       title: _titleController.text,
//                       body: _bodyController.text,
//                       date: formatter);
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //       builder: (context) => EditProfile()),
//                   // );
//                 },
//               )),
//               // Stack(
//               //   children: <Widget>[
//               //     Column(
//               //       crossAxisAlignment: CrossAxisAlignment.start,
//               //       children: <Widget>[
//               //         Container(height: 10.0),
//               //         //first element in the column is the white background (the Image.asset in your case)
//               //         DecoratedBox(
//               //             decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(30.0),
//               //                 color: redColor),
//               //             child: Container(
//               //               child: Padding(
//               //                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//               //                 child: Column(
//               //                   children: [
//               //                     TextField(
//               //                       keyboardType: TextInputType.text,
//               //                       decoration: InputDecoration(
//               //                           hintText: "Type in here"),
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ),
//               //               width: 350.0,
//               //               height: 50.0,
//               //             )),
//               //         //second item in the column is a transparent space of 20
//               //       ],
//               //     ),
//               //     Row(
//               //       mainAxisAlignment: MainAxisAlignment.end,
//               //       children: <Widget>[
//               //         // Container(
//               //         //   width: 170.0,
//               //         // ),
//               //         Column(
//               //           children: <Widget>[
//               //             InkWell(
//               //               child: Container(
//               //                 height: 65,
//               //                 width: 65,
//               //                 decoration: BoxDecoration(
//               //                   color: Colors.white,
//               //                   borderRadius: BorderRadius.circular(50),
//               //                   boxShadow: [
//               //                     BoxShadow(
//               //                       color: Colors.black.withOpacity(0.1),
//               //                       spreadRadius: 0,
//               //                       blurRadius: 10,
//               //                       offset: Offset(
//               //                           0, 10), // changes position of shadow
//               //                     ),
//               //                   ],
//               //                 ),
//               //                 child: Center(
//               //                   child: Icon(
//               //                     Icons.add,
//               //                     size: 30,
//               //                     color: redColor,
//               //                   ),
//               //                   // child: Text(
//               //                   //   "+",
//               //                   //   style: TextStyle(
//               //                   //       fontSize: 16,
//               //                   //       color: redColor,
//               //                   //       fontWeight: FontWeight.w500),
//               //                   // ),
//               //                 ),
//               //               ),
//               //               onTap: () {
//               //                 // Navigator.push(
//               //                 //   context,
//               //                 //   MaterialPageRoute(
//               //                 //       builder: (context) => EditProfile()),
//               //                 // );
//               //               },
//               //             )
//               //           ],
//               //         ),
//               //       ],
//               //     ),
//               //   ],
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
