import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/login.dart';
import 'package:toko_online/register.dart';
import 'dart:async';
import 'dart:convert' as convert;

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  // final formKey = GlobalKey<FormState>();

  Future _login() async {
    final response = await http
        .post(Uri.parse('http://192.168.0.102:8000/api/auth/register'), body: {
      'name': name.text,
      'email': email.text,
      'password': password.text,
    });
    if (response.statusCode == 201) {
      print(response.body);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
      return convert.jsonDecode(response.body);
    } else {
      print("error status " + response.statusCode.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 30),
                  child: Center(
                    child: Text(
                      "DAFTAR",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto-Regular"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  alignment: Alignment.topLeft,
                  // margin: EdgeInsets.fromLTRB(0, 0, 200, 6),
                  child: Text(
                    "Username",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: false,
                    hintText: "Masukkan Username",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 30),
                  alignment: Alignment.topLeft,
                  // margin: EdgeInsets.fromLTRB(0, 0, 200, 6),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: false,
                    hintText: "Masukkan Email",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, top: 30),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: false,
                    hintText: "Masukkan Password",
                    hintStyle: TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Sudah Punya Akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text("Masuk"),
                    ),
                  ],
                ),
                Container(
                  width: 508,
                  height: 45,
                  margin: EdgeInsets.only(top: 11.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff578BB8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    child: Text(
                      "Daftar",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      // if (formKey.currentState.validate()) {
                      _login();
                      // }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}