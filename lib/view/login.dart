import 'package:coller_mobile/theme.dart';
import 'package:coller_mobile/utils/CollageManagement/schedule.dart';
import 'package:coller_mobile/utils/CollageManagement/task.dart';
import 'package:coller_mobile/utils/CollageManagement/todolist.dart';
import 'package:coller_mobile/utils/income.dart';
import 'package:coller_mobile/utils/outcome.dart';
import 'package:coller_mobile/utils/profile.dart';
import 'package:coller_mobile/view/navbar.dart';
import 'package:coller_mobile/view/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLogin = false;
  bool obscureText = true;

  final _formKey = GlobalKey<FormState>();

  loginSubmit() async {
    try {
      setState(() {
        isLogin = true;
      });
      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) {
        uProfile.userUid = value.user!.uid;
        uProfile.getUserDoc();
        uTask.getLength();
        uSchedule.getLength();
        uTodolist.getLength();
        uIncome.getNama();
        uOutcome.getNama();
      }).then((value) {
        setState(() {
          isLogin = false;
        });
        // Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => navbar(index: 0)));
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please enter a valid email address.'),
        ));
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Email not registered.'),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Wrong password.'),
        ));
      }
      setState(() {
        isLogin = false;
      });
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
                height: 140,
              ),
              Text(
                'Coller',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'Log-In to Continue',
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
                          labelText: 'Email Address',
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 116, 110, 110),
                          ),
                          suffixIcon: Icon(
                            Icons.mail,
                            color: Color(0xFFF76963),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required.';
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
                            return 'Password field is required.';
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
                        loginSubmit();
                      }
                    },
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Color.fromARGB(255, 247, 105, 99),
                    padding: EdgeInsets.all(20),
                    child: isLogin
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Log-In",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  //action
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decorationThickness: 0, color: Color(0xFFF76963)),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any account ?",
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
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Register",
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
      ))),
    );
  }
}
