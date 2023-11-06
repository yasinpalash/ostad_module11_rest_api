import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _titelTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();

  Future<void> addNewProduct() async {
    final Map<String, String> inPutMap = {
      "Img":
          "https://www.startech.com.bd/image/cache/catalog/keyboard/a4-tech/bloody-s510r/bloody-s510r-500x500.webp",
      "ProductCode": "Yas9999",
      "ProductName": "kereeeeeee",
      "Qty": "64",
      "TotalPrice": "54554754",
      "UnitPrice": "100000000"
    };
    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inPutMap));
    print(response.request?.url);

    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titelTEController,
                decoration: const InputDecoration(
                    label: Text('Titel'),
                    hintText: 'Enter  Product Titel',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: _productCodeTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Product Code'),
                    hintText: 'Enter  Product code',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: _quantityTEController,
                decoration: const InputDecoration(
                    label: Text('Quantity'),
                    hintText: 'Enter  Quantity Titel',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: _priceTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Price'),
                    hintText: 'Enter  Product Price',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: _totalPriceTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    label: Text('Total Price'),
                    hintText: 'Enter  Total Product Price',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 5,
                decoration: const InputDecoration(
                    label: Text('Description'),
                    hintText: 'Enter  Product Description',
                    focusedBorder: OutlineInputBorder(),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        addNewProduct();
                      },
                      child: Text('ADD')))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titelTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
