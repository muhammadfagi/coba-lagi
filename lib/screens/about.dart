import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future getDataUser() async {
    String token = await SessionManager().get('access_token');
    final response = await http
        .post(Uri.parse('http://192.168.0.102:8000/api/auth/me'), body: {
      'token': token,
      
    });
    // print(response.body);
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData);
      return jsonData;
    } else {
      print('No Response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toko Online"),
      ),
      body: FutureBuilder<dynamic>(
        future: getDataUser(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Text(
              "${snapshot.error}",
              style: const TextStyle(fontSize: 20),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: const CircularProgressIndicator());
          } else {
            return Container(
              child: Row(
                children: [
                  Text(snapshot.data['name']),
                  Text(snapshot.data['email']),

                ],
              ),
            );
          }
        }
      ),
    );
  }
}