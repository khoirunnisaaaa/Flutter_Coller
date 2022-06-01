import 'package:coller_mobile/main.dart';
import 'package:coller_mobile/view/Dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../theme.dart';
import 'OverviewProfile.dart';
import 'indicator.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  int touchedIndex = -1;

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
                    'Chart % Income.',
                    style: titleTextStyle,
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
                              text: 'Gaji',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xff4D4D4E),
                              text: 'Orang Tua',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xffFF57BC),
                              text: 'Hadiah',
                              size: 12,
                              isSquare: false,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color(0xffFB4F4F),
                              text: 'Investasi',
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

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff9F43CC),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff4D4D4E),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffFF57BC),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xffFB4F4F),
            value: 15,
            title: '15%',
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
}

void doEdit(BuildContext context) {}
void doDelete(BuildContext context) {}
