import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:moduel/screens/product_list_screen.dart';

class AddNewProductScreen extends StatefulWidget {
  final Product? product;
  const AddNewProductScreen({super.key, this.product});
  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _titelTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool addInProcess = false;

  Future<void> addNewProduct() async {
    addInProcess = true;
    setState(() {});
    final Map<String, String> inPutMap = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "ProductName": _titelTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    final Response response = await post(
        Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inPutMap));

    if (response.statusCode == 200) {
      _titelTEController.clear();
      _productCodeTEController.clear();
      _imageTEController.clear();
      _quantityTEController.clear();
      _priceTEController.clear();
      _totalPriceTEController.clear();
      _descriptionTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product has been added')));
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product Code Should be unique')));
    }
    addInProcess = false;
    setState(() {});
    print(response.request?.url);
    print(response.statusCode);
  }

  Future<void> upDateProduct() async {
    addInProcess = true;
    setState(() {});
    final Map<String, String> inPutMap = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text.trim(),
      "ProductName": _titelTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    final Response response = await post(
        Uri.parse(
            'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product!.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(inPutMap));

    if (response.statusCode == 200) {
      _titelTEController.clear();
      _productCodeTEController.clear();
      _imageTEController.clear();
      _quantityTEController.clear();
      _priceTEController.clear();
      _totalPriceTEController.clear();
      _descriptionTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product has been updated')));
    } else if (response.statusCode == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(' Product Code Should be unique')));
    }
    addInProcess = false;
    setState(() {});
  }

  @override
  void initState() {
    if (widget.product != null) {
      _titelTEController.text = widget.product!.productName;
      _productCodeTEController.text = widget.product!.productCode;
      _imageTEController.text = widget.product!.image;
      _priceTEController.text = widget.product!.quantity;
      _quantityTEController.text = widget.product!.unitPrice;
      _totalPriceTEController.text = widget.product!.totalPrice;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titelTEController,
                  decoration: const InputDecoration(
                      label: Text('Titel'),
                      hintText: 'Enter  Product Titel',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Product Code'),
                      hintText: 'Enter  Product code',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                      label: Text('Image'),
                      hintText: 'Enter  Product image',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  decoration: const InputDecoration(
                      label: Text('Quantity'),
                      hintText: 'Enter  Quantity Titel',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _priceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Price'),
                      hintText: 'Enter  Product Price',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Total Price'),
                      hintText: 'Enter  Total Product Price',
                      focusedBorder: OutlineInputBorder(),
                      border: OutlineInputBorder()),
                  validator: isValidate,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                    width: double.infinity,
                    child: addInProcess
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                textStyle: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                if (widget.product == null) {
                                  addNewProduct();
                                } else {
                                  upDateProduct();
                                }
                              }
                            },
                            child: widget.product != null
                                ? const Text('Update')
                                : const Text('ADD')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? isValidate(String? value) {
    if (value?.trim().isNotEmpty ?? false) {
      return null;
    }
    return 'Enter valid value';
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
