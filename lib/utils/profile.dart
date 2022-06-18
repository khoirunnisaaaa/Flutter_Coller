import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _userCollection = _firestore.collection("users");

class uProfile {
  static String? userUid;
  static String? nama_lengkap;
  static String? email;
  static String? password;
  static String? no_hp;
  static String? prof_img;

  static getUserDoc() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid.toString())
        .get()
        .then((value) {
      uProfile.email = (value.data()!["email"]).toString();
      uProfile.password = (value.data()!["password"]).toString();
      uProfile.nama_lengkap = (value.data()!["nama_lengkap"]).toString();
      uProfile.no_hp = (value.data()!["phone"]).toString();
      uProfile.prof_img = (value.data()!["prof_img"]).toString();
    });
    print("User PROFIL : " + nama_lengkap.toString());
  }

  static Future<void> updateProfile({
    required String email,
    required String password,
    required String nama_lengkap,
    required String no_hp,
    required String prof_img,
  }) async {
    DocumentReference docRef = _userCollection.doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "nama_lengkap": nama_lengkap,
      "password": password,
      "phone": no_hp,
      "prof_img": prof_img
    };

    await docRef
        .update(data)
        .whenComplete(() => getUserDoc())
        .catchError((e) => log(e.toString()));
  }

  // static Future<void> addItem({
  //   required String profileImage,
  //   required String email,
  //   required String password,
  //   required String nama,
  //   required String nohp,
  // }) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   if (auth.currentUser != null) {
  //     userUid = auth.currentUser!.uid.toString();
  //     print(auth.currentUser!.uid);
  //   }

  //   DocumentReference documentReference =
  //       _profileCollection.doc(userUid).collection('items').doc();

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "profile_img": profileImage,
  //     "email": email,
  //     "password": password,
  //     "nama": nama,
  //     "nohp": nohp
  //   };
  //   await documentReference
  //       .set(data)
  //       .whenComplete(() => print("Profil telah ditambahkan"))
  //       .catchError((e) => print(e));
  // }
}
