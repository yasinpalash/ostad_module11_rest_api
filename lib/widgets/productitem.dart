import 'package:flutter/material.dart';
import 'package:moduel/screens/add_new_product_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

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
        'https://media1.popsugar-assets.com/files/thumbor/ahSeFFd7VEgBV1fJcl_OSnJYYH8=/0x0:1500x1500/fit-in/1584x1584/filters:format_auto():upscale()/2023/07/13/896/n/1922507/dff1438e64b05eeae74dc7.67262441_.jpg',
        width: 80,
      ),
      title: Text('Product name '),
      subtitle: const Column(
        children: [
          Row(
            children: [
              Text('Product name '),
              SizedBox(width: 24,),
              Text('Product name '),


            ],
          ),
          Text('Product Description '),
        ],
      ),
      trailing: Text('\$120'),
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
                            builder: (context) =>
                                const AddNewProductScreen()),
                      );
                    },
                    leading: Icon(Icons.edit),
                  ),
                  ListTile(
                    title: Text('Delete'),
                    onTap: (){
                      Navigator.pop(context);
                    },
                    leading: Icon(Icons.delete_outlined),
                  )
                ],
              ),
            );
  }
}
