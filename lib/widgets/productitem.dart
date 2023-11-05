import 'package:flutter/material.dart';
import 'package:moduel/screens/add_new_product_screen.dart';
import 'package:moduel/screens/product_list_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return ProductActionDialog(context);
            });
      },
      leading: Image.network(
        product.image,
        width: 80,
      ),
      title: Text(product.productName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product.productCode),
          Text('Total Price:${product.totalPrice}'),
        ],
      ),
      trailing: Text('\$${product.unitPrice}'),
    );
  }

  AlertDialog ProductActionDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Select Action  '),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewProductScreen()),
              );
            },
            leading: Icon(Icons.edit),
          ),
          ListTile(
            title: Text('Delete'),
            onTap: () {
              Navigator.pop(context);
            },
            leading: Icon(Icons.delete_outlined),
          )
        ],
      ),
    );
  }
}
