import 'package:flutter/material.dart';
import 'package:toko_online/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController imageurl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future addProduct() async {
    print(name.text);
    final response = await http
        .post(Uri.parse('http://192.168.0.102:8000/api/products'), body: {
      'name': name.text,
      'description': description.text,
      'price': price.text,
      'image_url': imageurl.text,
    });
    print(response.body);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Input Name Product!!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextFormField(
              controller: description,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Input Description Product!!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Description",
              ),
            ),
            TextFormField(
              controller: price,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Input Price Product!!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Price",
              ),
            ),
            TextFormField(
              controller: imageurl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Input Image Product!!";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Image Url",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addProduct().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Produk Berhasil Ditambah")));
                    });
                  }
                },
                child: Text("Save"))
          ]),
        ),
      ),
    );
  }
}
