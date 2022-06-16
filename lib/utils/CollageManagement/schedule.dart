import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/utils/profile.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _scheduleCollection =
    _firestore.collection("schedule");

class uSchedule {
  static String? userUid = uProfile.userUid;
  static String? hari;
  static int? totalSchedule;

  static void getLength() async {
    FirebaseFirestore.instance
        .collection("schedule")
        .doc(userUid)
        .collection("items")
        .where("day", isEqualTo: "Senin")
        .get()
        .then((value) {
      totalSchedule = value.docs.length;
      print("Senin Length : " + value.docs.length.toString());
    });
  }

  static Future<void> addItem({
    required String day,
    required String topic,
    required String timeStart,
    required String timeEnd,
  }) async {
    DocumentReference documentReference =
        _scheduleCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "day": day,
      "topic": topic,
      "timestart": timeStart,
      "timeend": timeEnd,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Schedule telah ditambahkan"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String docId,
    required String day,
    required String topic,
    required String timeStart,
    required String timeEnd,
  }) async {
    DocumentReference documentReference =
        _scheduleCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "day": day,
      "topic": topic,
      "timestart": timeStart,
      "timeend": timeEnd,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log("Todos Updated!"))
        .catchError((e) => log(e));
  }

  static Stream<QuerySnapshot> readItems(String hari) {
    Query<Map<String, dynamic>> todosItemCollection = _scheduleCollection
        .doc(userUid)
        .collection('items')
        .where("day", isEqualTo: hari);

    return todosItemCollection.snapshots();
  }

  static Future<void> deleteItem({required String docId}) async {
    DocumentReference documentReference =
        _scheduleCollection.doc(userUid).collection("items").doc(docId);
    await documentReference
        .delete()
        .whenComplete(() => print('Schedule deleted'))
        .catchError((e) => print(e));
  }
}
