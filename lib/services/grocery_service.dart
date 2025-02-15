import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';

final Uri url = Uri.https(
    'shoppinglistserver-f1886-default-rtdb.firebaseio.com',
    'shopping-list.json');

class GroceryService {
  const GroceryService();

  Future<http.Response> saveGroceryItem(GroceryItem item) {
    return http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        item.toMap(),
      ),
    );
  }

  Future<http.Response> deleteGrocery(GroceryItem item) {
    final Uri url = Uri.https(
        'shoppinglistserver-f1886-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    return http.delete(
      url,
      // headers: {'Content-Type': 'application/json'},
      // body: json.encode(
      //   item.toMap(),
      // ),
    );
  }

  Future<http.Response> get loadGroceries {
    return http.get(url, headers: {'Content-Type': 'application/json'});
  }
}
