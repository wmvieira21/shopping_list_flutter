import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';

final Uri url = Uri.https(
    'shoppinglistserver-f1886-default-rtdb.firebaseio.com',
    'shopping-list.json');

class GroceryService {
  const GroceryService();

  Future<dynamic> groceryItemPost(GroceryItem item) {
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        item.toMap(),
      ),
    );
  }

  Future<List<GroceryItem>> groceryItemGet() {
    List<GroceryItem> groceries = [];
    return http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    ).then((response) {
      Map<String, dynamic> shoppingListMap =
          (jsonDecode(response.body) as Map<String, dynamic>);

      shoppingListMap.forEach((id, valueMap) {
        groceries.add(
          GroceryItem.toObject(id, valueMap),
        );
      });
      return groceries;
    });
  }
}
