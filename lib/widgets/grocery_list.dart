import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList(
      {super.key, required this.groceriesList, required this.onDeletingItem});

  final List<GroceryItem> groceriesList;
  final Function(GroceryItem item) onDeletingItem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: groceriesList.length,
        itemBuilder: (context, index) {
          GroceryItem grocery = groceriesList[index];
          return Dismissible(
            key: ValueKey(grocery),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                onDeletingItem(grocery);
              }
            },
            background: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(121, 211, 56, 56),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: ListTile(
              leading: SizedBox.square(
                dimension: 20,
                child: ColoredBox(color: grocery.category.color),
              ),
              title: Text(grocery.name),
              trailing: Text(grocery.quantity.toString()),
            ),
          );
        });
  }
}
