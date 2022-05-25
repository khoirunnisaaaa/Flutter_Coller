import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 150,
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
                  border: Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
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
                          return 'Email tidak boleh kosong';
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
                  border: Border.all(color: Color.fromARGB(235, 235, 235, 235)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 116, 110, 110),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password Tidak Boleh Kosong';
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 400,
                child: RaisedButton(
                  onPressed: () {},
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Color.fromARGB(255, 247, 105, 99),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Log-In",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}