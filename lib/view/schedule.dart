// import 'package:flutter/material.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

// class schedule extends StatefulWidget {
//   const schedule({Key? key}) : super(key: key);

//   @override
//   State<schedule> createState() => _scheduleState();
// }

// class _scheduleState extends State<schedule> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SlidingUpPanel(
//         maxHeight: size.height,
//         minHeight: size.height * 0.5,
//         borderRadius: BorderRadius.circular(25),
//         body: SafeArea(
//           child: Text("This is the Widget behind the sliding panel"),
//         ),
//         panel: SafeArea(
//             child: Text("This is the Widget behind the sliding panel")),
//       ),
//     );
//   }
// }
