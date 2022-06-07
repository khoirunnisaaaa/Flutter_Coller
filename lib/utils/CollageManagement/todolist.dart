import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _todoCollection = _firestore.collection("todolist");

class uTodolist {
  static String? userUid;

  static Future<void> addItem({
    required String todos,
    required String status,
  }) async {
    DocumentReference documentReference =
        _todoCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "todos": todos,
      "status": status,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("Todos telah ditambahkan"))
        .catchError((e) => print(e));
  }

  static Future<void> updateItem({
    required String todos,
    required String status,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _todoCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "todos": todos,
      "status": status,
    };

    await documentReference
        .update(data)
        .whenComplete(() => log("Todos Updated!"))
        .catchError((e) => log(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference todosItemCollection =
        _todoCollection.doc(userUid).collection("items");

    return todosItemCollection.snapshots();
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReference =
        _todoCollection.doc(userUid).collection('items').doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print('Todolist deleted'))
        .catchError((e) => print(e));
  }
}
