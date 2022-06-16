import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/utils/profile.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _taskCollection = _firestore.collection("task");

class uTask {
  static String? userUid = uProfile.userUid;
  static int? totalTask;
  static List<String> dataItems = [];

  static void getLength() async {
    FirebaseFirestore.instance
        .collection("task")
        .doc(userUid)
        .collection("items")
        .where("status", isEqualTo: "false")
        .get()
        .then((value) {
      totalTask = value.docs.length;
      print("Task Length : " + value.docs.length.toString());
    });
  }

  // static List<int> listIncome = [];

  // static int totalIncome = 0;

  // static getNama() async {
  //   var data = await FirebaseFirestore.instance
  //       .collection("income")
  //       .doc("S4w8PsNVDkWsDweKpGEcaggVMtn2")
  //       .collection("items")
  //       .get();

  //   for (int i = 0; i < data.docs.length; i++) {
  //     String totIncome = (data.docs[i].data()['income']).toString();

  //     totalIncome += int.parse(totIncome);
  //     // listIncome.add(data.docs[i].data()['income']);
  //   }

  //   // for (var i = 0; i < listIncome.length; i++) {
  //   //   print(listIncome[i]);
  //   //   totIncome += listIncome[i];
  //   // }

  //   print("Total income : " + totalIncome.toString());
  // }

  static Future<void> addItem({
    required String catTask,
    required String task,
    required String date,
    required String status,
  }) async {
    DocumentReference documentReference =
        _taskCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "task_category": catTask,
      "task": task,
      "date": date,
      "status": status,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Task telah ditambahkan"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String docId,
    required String catTask,
    required String task,
    required String date,
    required String status,
  }) async {
    DocumentReference documentReference =
        _taskCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "task_category": catTask,
      "task": task,
      "date": date,
      "status": status,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log("Todos Updated!"))
        .catchError((e) => log(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference todosItemCollection =
        _taskCollection.doc(userUid).collection("items");

    return todosItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _taskCollection.doc(userUid).collection('items').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Todolist deleted'))
        .catchError((e) => print(e));
  }
}
