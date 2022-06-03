import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/view/OverviewProfile.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => navbar()),
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
                      InkWell(
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 45,
                          width: 45,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OverviewProfile()),
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
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
                          DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: redColor),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Column(
                                    children: [
                                      TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: "Type in here"),
                                      ),
                                    ],
                                  ),
                                ),
                                width: 350.0,
                                height: 50.0,
                              )),
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
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => EditProfile()),
                                  // );
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
                  Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: const ValueKey(0),

                    // The end action pane is the one at the right or the bottom side.
                    endActionPane: const ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.
                          onPressed: doEdit,
                          backgroundColor: Color.fromARGB(255, 99, 185, 255),
                          foregroundColor: Colors.white,
                          icon: Icons.edit_rounded,
                        ),
                        SlidableAction(
                          onPressed: doDelete,
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
                            value: true,
                            onChanged: null,
                          ),
                          title: Text(
                            'Mengerjakan tugas WSI',
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
                  ),
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
