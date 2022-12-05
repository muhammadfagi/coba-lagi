import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class ProductDetail extends StatefulWidget {
  final Map product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Future addOrder() async {
    String token = await SessionManager().get('token');
    // print(name.text);
    // var url = Uri.http('192.168.0.102:8000', '/api/auth/orders');
    // var response = await http.post(url, body: {
    //   'user_id': widget.product['id'],
    //   'product_id': widget.product['id'],
    //   'total_order': '4',
    //   'total_price': '100',
    //   'status' : '0',
    // }, headers: {
    //   'Content-Type': 'application/json',cd
    //   'Accept': 'application/json',
    //   'Authorization' : 'Bearer $token'
    // });
    final response =
        await http.post(Uri.parse('http://192.168.0.102:8000/api/orders'),
            body: jsonEncode({
              'user_id': widget.product['id'],
              'product_id': widget.product['id'],
              'total_order': 4,
              'total_price': widget.product['price'],
              'status': 0,
            }),
            headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    print(response.body);
    // var jsonData = convert.jsonDecode(response.body);

    return jsonEncode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dasd"),
      ),
      body: Column(
        children: [
          Container(
            child: Text(widget.product['name']),
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
                addOrder();
                // }
              },
            ),
          ),
          // Text(widget.product['category']['name']),
        ],
      ),
    );
  }
}
