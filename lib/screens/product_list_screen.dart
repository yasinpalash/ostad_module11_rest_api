import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moduel/screens/add_new_product_screen.dart';

import '../widgets/productitem.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool inProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    getProductList();
    super.initState();
  }

  void getProductList() async {
    productList.clear();
    inProgress = true;
    setState(() {});
    Response response = await get(
      Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct'),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseDate = jsonDecode(response.body);
      if (responseDate['status'] == 'success') {
        for (Map<String, dynamic> productJson in responseDate['data']) {
          productList.add(Product(
            productJson['_id'],
            productJson['ProductName'] ?? '',
            productJson['ProductCode'] ?? '',
            productJson['Img'] ?? '',
            productJson['UnitPrice'] ?? '',
            productJson['Qty'] ?? '',
            productJson['TotalPrice'] ?? '',
          ));
        }
      }
    }
    inProgress = false;
    setState(() {});
  }
  void deleteProduct(String productId) async {
    inProgress = true;
    setState(() {});
    Response response = await get(
      Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId'),
    );
    if (response.statusCode == 200) {
      getProductList();

    }
    else {
      inProgress = false;
      setState(() {});
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            onPressed: () {
              getProductList();
            },
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddNewProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: inProgress
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: productList[index], onPressDelete: (String productId) {
                    deleteProduct(productId);

                },
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            ),
    );
  }
}

class Product {
  final String id;
  final String productName;
  final String productCode;
  final String image;
  final String unitPrice;
  final String quantity;
  final String totalPrice;

  Product(this.id, this.productName, this.productCode, this.image,
      this.unitPrice, this.quantity, this.totalPrice);
}
