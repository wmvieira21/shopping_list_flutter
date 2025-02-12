import 'package:flutter/material.dart';
import 'package:shopping_list/data/groceries.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groceriesItemsData.length,
        itemBuilder: (context, index) {
          GroceryItem grocery = groceriesItemsData[index];
          return ListTile(
            leading: SizedBox.square(
              dimension: 20,
              child: ColoredBox(color: grocery.category.color),
            ),
            title: Text(grocery.name),
            trailing: Text(grocery.quantity.toString()),
          );
        });
  }
}
