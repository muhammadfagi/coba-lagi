import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/add_product.dart';
import 'package:toko_online/screens/edit_product.dart';
import 'dart:async';
import 'dart:convert' as convert;
import 'package:toko_online/screens/product_detail.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getProducts() async {
    String token = await SessionManager().get('token');
    var url = Uri.http('192.168.0.102:8000', '/api/auth/products');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    });
    var jsonData = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonData['data']);
      return jsonData['data'];
    } else {
      print('No Response');
    }
  }

  Future deleteProduct(String productId) async {
    var url = Uri.http('192.168.0.102:8000', '/api/products/' + productId);
    var response = await http.delete(url);
    return convert.jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
      ),
      appBar: AppBar(
        title: Text("Toko Onlines"),
      ),
      body: FutureBuilder<dynamic>(
        future: getProducts(),
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  height: 180,
                  child: Card(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProductDetail(
                                    product: snapshot.data[index],
                                  );
                                }));
                              },
                              child: Text(snapshot.data[index]['name'])),
                          Text(snapshot.data[index]['price'].toString()),
                          // Text(snapshot.data[index]['category'].toString()),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                            product: snapshot.data[index])));
                              },
                              child: Icon(Icons.edit)),
                          GestureDetector(
                              onTap: () {
                                deleteProduct(
                                        snapshot.data[index]['id'].toString())
                                    .then((value) {
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Hapus Produk Berhasil")));
                                });
                              },
                              child: Icon(Icons.delete)),
                        ]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
