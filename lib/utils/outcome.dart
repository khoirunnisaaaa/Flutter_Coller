import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/utils/profile.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _outcomeCollection = _firestore.collection("outcome");

class uOutcome {
  static String? userUid = uProfile.userUid;

  static int totalOutcome = 0;

  static double totalFood = 0;
  static double totalEducation = 0;
  static double totalEntertainment = 0;
  static double totalEtc = 0;

  static int totalData = 0;

  // presentase
  static double persenFood = 0;
  static double persenEducation = 0;
  static double persenEntertainment = 0;
  static double persenEtc = 0;

  static getNama() async {
    var data = await FirebaseFirestore.instance
        .collection("outcome")
        .doc(userUid)
        .collection("items")
        .get();

    var dataFood = await FirebaseFirestore.instance
        .collection("outcome")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Food')
        .get();

    var dataEducation = await FirebaseFirestore.instance
        .collection("outcome")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Education')
        .get();

    var dataEntertainment = await FirebaseFirestore.instance
        .collection("outcome")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Entertainment')
        .get();

    var dataEtc = await FirebaseFirestore.instance
        .collection("outcome")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: '.etc')
        .get();

    // totalGift = (dataGift.size) / totalData * 100;
    if (totalOutcome != 0) {
      totalOutcome = 0;
      totalFood = 0;
      totalEducation = 0;
      totalEntertainment = 0;
      totalEtc = 0;
    }

    for (int i = 0; i < data.docs.length; i++) {
      String totOutcome = (data.docs[i].data()['outcome']).toString();

      totalOutcome = totalOutcome + int.parse(totOutcome);
    }

    for (int i = 0; i < dataFood.docs.length; i++) {
      String totFood = (dataFood.docs[i].data()['outcome']).toString();
      totalFood = totalFood + int.parse(totFood);
    }

    for (int i = 0; i < dataEducation.docs.length; i++) {
      String totEducation =
          (dataEducation.docs[i].data()['outcome']).toString();
      totalEducation = totalEducation + int.parse(totEducation);
    }

    for (int i = 0; i < dataEntertainment.docs.length; i++) {
      String totEntertainment =
          (dataEntertainment.docs[i].data()['outcome']).toString();
      totalEntertainment = totalEntertainment + int.parse(totEntertainment);
    }

    for (int i = 0; i < dataEtc.docs.length; i++) {
      String totEtc = (dataEtc.docs[i].data()['outcome']).toString();
      totalEtc = totalEtc + int.parse(totEtc);
    }

    print('Food: ${totalFood}');
    print('Education: ${totalEducation}');
    print('Entertainment: ${totalEntertainment}');
    print('etc: ${totalEtc}');

    persenFood = totalFood / totalOutcome * 100;
    persenEducation = totalEducation / totalOutcome * 100;
    persenEntertainment = totalEntertainment / totalOutcome * 100;
    persenEtc = totalEtc / totalOutcome * 100;

    print("Total outcome : " + totalOutcome.toString());
  }

  static Future<void> addItem({
    required String title,
    required String category,
    required String date,
    required int outcome,
  }) async {
    print(userUid);
    DocumentReference documentReference =
        _outcomeCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "category": category,
      "date": date,
      "outcome": outcome,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Outcome telah ditambahkan"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference outcomeItemCollection =
        _outcomeCollection.doc(userUid).collection("items");

    return outcomeItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String category,
    required String date,
    required int outcome,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _outcomeCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "category": category,
      "date": date,
      "outcome": outcome,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log("Outcome item updated in the database"))
        .catchError((e) => log(e));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _outcomeCollection.doc(userUid).collection('items').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Outcome deleted'))
        .catchError((e) => print(e));
  }
}
