import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/services/grocery_service.dart';
import 'package:shopping_list/widgets/grocery_list.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/widgets/no_data_found.dart';

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<GroceryHomePage> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  final List<GroceryItem> _groceriesList = [];
  final GroceryService groceryService = GroceryService();
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    loadSavedGroceries;
  }

  get loadSavedGroceries {
    _groceriesList.clear();
    return groceryService.savedGroceries.then((response) {
      setState(() {
        if (response['statusCode'] != null) {
          errorMessage = response['errorMessage'];
          return;
        }

        isLoading = false;
        _groceriesList.addAll(response['groceries']);
      });
    });
  }

  void _addItem() {
    Navigator.of(context)
        .push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => NewItem(),
      ),
    )
        .then((item) {
      if (item != null) {
        setState(() {
          _groceriesList.add(item);
        });
      }
    });
  }

  void _deleteItem(GroceryItem item) {
    setState(() {
      _groceriesList.remove(item);
      groceryService.deleteGrocery(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _groceriesList.isEmpty
        ? NoDataFound()
        : GroceryList(
            groceriesList: _groceriesList,
            onDeletingItem: (item) => _deleteItem(item));

    if (isLoading) {
      mainContent = Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage.isNotEmpty) {
      mainContent = Center(
        child: Text(errorMessage),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          IconButton.outlined(onPressed: _addItem, icon: Icon(Icons.add))
        ],
      ),
      body: mainContent,
    );
  }
}
