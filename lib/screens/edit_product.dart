import 'package:flutter/material.dart';
import 'package:toko_online/screens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProduct extends StatefulWidget {
  final Map product;

  const EditProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController imageurl = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future editProduct() async {
    print(name.text);
    final response = await http.put(
        Uri.parse("http://192.168.0.102:8000/api/products/" +
            widget.product['id'].toString()),
        body: {
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
        title: Text("Edit Product"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: name..text = widget.product['name'],
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
              controller: description..text = widget.product['description'],
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
              controller: price..text = widget.product['price'],
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
              controller: imageurl..text = widget.product['image_url'],
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
                    editProduct().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Edit Produk Berhasil")));
                    });
                  }
                },
                child: Text("Update"))
          ]),
        ),
      ),
    );
  }
}
