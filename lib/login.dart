import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/register.dart';
import 'package:toko_online/screens/about.dart';
import 'dart:async';
import 'dart:convert' as convert;

import 'screens/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  // final formKey = GlobalKey<FormState>();

  Future _login() async {
    final response = await http
        .post(Uri.parse('http://192.168.0.102:8000/api/auth/login'), body: {
      'email': email.text,
      'password': password.text,
    });
    var login = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      await SessionManager().set('token', login['token']);
      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
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
                  margin: EdgeInsets.fromLTRB(0, 150, 0, 30),
                  child: Center(
                    child: Text(
                      "LOGIN",
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
                  controller: email,
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
                    Text("Belum Punya Akun?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text("Daftar"),
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
                      "Login",
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
