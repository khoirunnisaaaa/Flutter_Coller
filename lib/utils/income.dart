import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/utils/profile.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _incomeCollection = _firestore.collection("income");

class uIncome {
  static String? userUid = uProfile.userUid;

  static int totalIncome = 0;
  static double totalSalary = 0;
  static double totalGift = 0;
  static double totalParent = 0;
  static double totalEtc = 0;

  static int totalData = 0;

  // persentase
  static double persenSalary = 0;
  static double persenGift = 0;
  static double persenParent = 0;
  static double persenEtc = 0;

  static getNama() async {
    var data = await FirebaseFirestore.instance
        .collection("income")
        .doc(userUid)
        .collection("items")
        // .where('category', isEqualTo: 'Gift')
        .get();

    var dataSalary = await FirebaseFirestore.instance
        .collection("income")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Salary')
        .get();

    var dataGift = await FirebaseFirestore.instance
        .collection("income")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Gift')
        .get();

    var dataParent = await FirebaseFirestore.instance
        .collection("income")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: 'Parent')
        .get();

    var dataEtc = await FirebaseFirestore.instance
        .collection("income")
        .doc(userUid)
        .collection("items")
        .where('category', isEqualTo: '.etc')
        .get();

    // totalData = data.size;

    // totalGift = (dataGift.size) / totalData * 100;
    if (totalIncome != 0) {
      totalIncome = 0;
      totalSalary = 0;
      totalGift = 0;
      totalParent = 0;
      totalEtc = 0;
    }
    for (int i = 0; i < data.docs.length; i++) {
      String totIncome = (data.docs[i].data()['income']).toString();
      totalIncome = totalIncome + int.parse(totIncome);
    }

    for (int i = 0; i < dataSalary.docs.length; i++) {
      String totSalary = (dataSalary.docs[i].data()['income']).toString();
      totalSalary = totalSalary + int.parse(totSalary);
    }

    for (int i = 0; i < dataGift.docs.length; i++) {
      String totGift = (dataGift.docs[i].data()['income']).toString();
      totalGift = totalGift + int.parse(totGift);
    }

    for (int i = 0; i < dataParent.docs.length; i++) {
      String totParent = (dataParent.docs[i].data()['income']).toString();
      totalParent = totalParent + int.parse(totParent);
    }

    for (int i = 0; i < dataEtc.docs.length; i++) {
      String totEtc = (dataEtc.docs[i].data()['income']).toString();
      totalEtc = totalEtc + int.parse(totEtc);
    }

    print('salary: ${totalSalary}');
    print('gift: ${totalGift}');
    print('parent: ${totalParent}');
    print('etc: ${totalEtc}');

    persenSalary = totalSalary / totalIncome * 100;
    persenGift = totalGift / totalIncome * 100;
    persenParent = totalParent / totalIncome * 100;
    persenEtc = totalEtc / totalIncome * 100;

    print(
        'total income: ${totalIncome} | ${persenGift} || total salary: ${totalSalary} || total gift ${totalGift}');
    // print("Total income : " + totalIncome.toString());
    // print(totalSalary.toString() + " || " + totalGift.toString());
    // print(totalData.toString());
  }

  static Future<void> addItem({
    required String title,
    required String category,
    required String date,
    required int income,
  }) async {
    // print(userUid);
    DocumentReference documentReference =
        _incomeCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "category": category,
      "date": date,
      "income": income,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Income telah ditambahkan"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference incomeItemCollection =
        _incomeCollection.doc(userUid).collection("items");

    return incomeItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String category,
    required String date,
    required int income,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _incomeCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "category": category,
      "date": date,
      "income": income,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log("Income item updated in the database"))
        .catchError((e) => log(e));
  }

  static Future<void> deleteItem({required String docId}) async {
    DocumentReference documentReference =
        _incomeCollection.doc(userUid).collection('items').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Income deleted'))
        .catchError((e) => print(e));
  }
}
