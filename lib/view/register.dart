import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/view/login.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscureText = true;
  bool obscureTextConf = true;

  registerSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) async {
        print(value.user!.uid.toString());
        DocumentReference docRef =
            _firestore.collection("users").doc(value.user!.uid.toString());

        Map<String, dynamic> data = <String, dynamic>{
          "nama_lengkap": _namaController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
          "phone": _nohpController.text,
          "prof_img":
              "https://firebasestorage.googleapis.com/v0/b/coller-me.appspot.com/o/prof_img%2Fcute-an-astronaut-sits-in-internet-vector-22760432.jpg?alt=media&token=02d1f34d-766b-4f3b-817c-8c1437d96c6c"
        };
        await docRef
            .set(data)
            .whenComplete(() => print(
                "Data telah ditambahkan, UID : " + value.user!.uid.toString()))
            .catchError((e) => print(e));
      }).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => navbar(index: 0)));
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Email already registered.  '),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Coller',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Create New Account',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),

                //Form text field ini
                SizedBox(
                  height: 39,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(235, 235, 235, 235),
                      border:
                          Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'irenebae@gmail.com',
                            labelText: 'Email Address',
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Color(0xFFF76963),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email field is required.';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(235, 235, 235, 235),
                      border:
                          Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                print("Clicked!");
                                setState(() {
                                  obscureText = !obscureText;
                                });
                                print(obscureText);
                              },
                              child: obscureText == true
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(255, 116, 110, 110),
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: redColor,
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 8) {
                              return 'Password length must be > 8 characters';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(235, 235, 235, 235),
                      border:
                          Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _confPasswordController,
                          obscureText: obscureTextConf,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Confirm Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                print("Clicked!");
                                setState(() {
                                  obscureTextConf = !obscureTextConf;
                                });
                                print(obscureTextConf);
                              },
                              child: obscureTextConf == true
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(255, 116, 110, 110),
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: redColor,
                                    ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm password field is required.';
                            } else if (value != _passwordController.text) {
                              return 'Wrong password.';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(235, 235, 235, 235),
                      border:
                          Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Irene Bae',
                            labelText: 'Full Name',
                            suffixIcon: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 116, 110, 110),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Full Name field is required.';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 42),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(235, 235, 235, 235),
                      border:
                          Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: TextFormField(
                          controller: _nohpController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '085398334040',
                            labelText: 'Phone',
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Color.fromARGB(255, 116, 110, 110),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone field is required.';
                            } else if (value.length < 11) {
                              return 'Please enter valid phone.';
                            }
                            return null;
                          }),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 42),
                  child: Container(
                    width: 400,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // _formKey.currentState!.save();
                          registerSubmit();
                        }
                        // registerSubmit();
                      },
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Color.fromARGB(255, 247, 105, 99),
                      padding: EdgeInsets.all(20),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6F6F6F),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xFFF76963),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
