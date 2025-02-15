import 'dart:convert';
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
  final GroceryService groceryService = GroceryService();
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = loadSavedGroceries;
  }

  Future<List<GroceryItem>> get loadSavedGroceries {
    List<GroceryItem> loadedList = [];
    return groceryService.loadGroceries.then((response) {
      if (response.statusCode >= 400) {
        throw Exception("Failed to fetch data. Please try again later.");
      }

      if (response.body.contains('category')) {
        Map<String, dynamic> shoppingListMap =
            (jsonDecode(response.body) as Map<String, dynamic>);

        shoppingListMap.forEach((id, valueMap) {
          loadedList.add(
            GroceryItem.toObject(id, valueMap),
          );
        });
      }
      return loadedList;
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
          _loadedItems = loadSavedGroceries;
        });
      }
    });
  }

  void _deleteItem(GroceryItem item) {
    groceryService.deleteGrocery(item).then((response) {
      if (response.statusCode >= 400) {
        _showErrorSnackbar("Item couldn't be deleted on the server.");
      }
      setState(() {
        _loadedItems = loadSavedGroceries;
      });
    }).catchError((error) {
      _showErrorSnackbar(
          "Server couldn't be reached. Check your internet connection.");
    });
  }

  _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Groceries'),
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          IconButton.outlined(onPressed: _addItem, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.data!.isEmpty) {
              return NoDataFound();
            }
            return GroceryList(
                groceriesList: snapshot.data!,
                onDeletingItem: (item) => _deleteItem(item));
          }),
    );
  }
}
