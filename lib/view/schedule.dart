import 'package:coller_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class schedule extends StatefulWidget {
  const schedule({Key? key}) : super(key: key);

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: MaterialButton(
          onPressed: () {},
          minWidth: 35.0,
          height: 35.0,
          color: redColor,
          textColor: Colors.white,
          child: Icon(
            Icons.chevron_left,
          ),
          // padding: EdgeInsets.only(right: 16.0),
          shape: CircleBorder(),
        ),
        leadingWidth: 35,
        title: Text(
          "Schedule",
          style: TextStyle(color: redColor),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Image.asset(
              "assets/images/profile.png",
              height: 45,
              width: 45,
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => OverviewProfile()),
              // );
            },
          )
        ],
      ),
      body: SlidingUpPanel(
        maxHeight: size.height,
        minHeight: size.height * 0.5,
        borderRadius: BorderRadius.circular(25),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Schedule.",
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              width: 200.0,
            ),
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
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Task Category"),
                                ),
                                SizedBox(
                                  width: 200,
                                ),
                                TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Task Category"),
                                ),
                                SizedBox(
                                  width: 200,
                                ),
                                TextField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      hintText: "Task Category"),
                                ),
                              ],
                            ),
                          ),
                          width: 400.0,
                          height: 250.0,
                        )),
                    //second item in the column is a transparent space of 20
                    Container(height: 20.0),
                  ],
                ),
                //for the button i create another column
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
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 13, color: redColor),
                        ),
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => EditProfile()),
                      // );
                    },
                  ))
                ])
              ],
            ),
          ],
        )),
        panel: SafeArea(
            child: Text("This is the Widget behind the sliding panel")),
      ),
    );
  }
}
