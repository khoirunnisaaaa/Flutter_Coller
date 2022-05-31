import 'package:coller_mobile/main.dart';
import 'package:coller_mobile/view/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../theme.dart';
import 'OverviewProfile.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SlidingUpPanel(
        padding: EdgeInsets.all(20),
        maxHeight: size.height,
        minHeight: size.height * 0.1,
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
                            MaterialPageRoute(
                                builder: (context) => Dashboard()),
                          );
                        },
                      ),
                      Text(
                        'Income',
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
                  SizedBox(height: 30),
                  Text(
                    'New Income.',
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
                                        TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Category *',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Title must be filled';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.datetime,
                                          decoration: InputDecoration(
                                            labelText: 'Date *',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Title must be filled';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Income(Rp.) *',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Income must be filled';
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
                        left: 70,
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
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
                          },
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
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
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
                    'Chart % Income.',
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 10),
                  Image.asset("assets/images/pie_chart.png"),
                  SizedBox(height: 30),
                  Text(
                    'History Income.',
                    style: titleTextStyle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '12/06/2022',
                    style: dateMMTextStyle,
                  ),
                  // SLIDE-ABLE
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
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit_note_rounded,
                          label: 'Edit',
                        ),
                        SlidableAction(
                          onPressed: doDelete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_rounded,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            'Gaji bulan juni',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            "1.200.000",
                            style: TextStyle(color: Color(0xff464646)),
                          ),
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
