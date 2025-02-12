import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_list.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/widgets/no_data_found.dart';

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  List<GroceryItem> _groceriesList = [];

  void _addItem() {
    Navigator.of(context)
        .push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    )
        .then((value) {
      if (value != null) {
        setState(() {
          _groceriesList.add(value);
        });
      }
    });
  }

  void _deleteItem(GroceryItem item) {
    setState(() {
      _groceriesList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _groceriesList.isEmpty
        ? NoDataFound()
        : GroceryList(
            groceriesList: _groceriesList,
            onDeletingItem: (item) => _deleteItem(item));

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        actions: [
          IconButton.filled(onPressed: _addItem, icon: Icon(Icons.add))
        ],
      ),
      body: mainContent,
    );
  }
}
