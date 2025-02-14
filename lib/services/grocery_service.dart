import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_list/models/grocery_item.dart';

final Uri url = Uri.https(
    'shoppinglistserver-f1886-default-rtdb.firebaseio.com',
    'shopping-list.json');

class GroceryService {
  const GroceryService();

  Future<http.Response> saveGroceryItem(GroceryItem item) {
    return http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(
            item.toMap(),
          ),
        )
        .catchError((error) => error);
  }

  Future<http.Response> deleteGrocery(GroceryItem item) {
    final Uri url = Uri.https(
        'shoppinglistserver-f1886-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');
    return http
        .delete(
          url,
          // headers: {'Content-Type': 'application/json'},
          // body: json.encode(
          //   item.toMap(),
          // ),
        )
        .catchError((error) => error);
  }

  Future<Map<String, dynamic>> get loadGroceries {
    List<GroceryItem> groceries = [];
    return http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    ).then((response) {
      if (response.statusCode >= 400) {
        return {
          'statusCode': response.statusCode,
          'errorMessage': "Failed to fetch data. Please try again later."
        };
      }

      if (response.body.contains('category')) {
        Map<String, dynamic> shoppingListMap =
            (jsonDecode(response.body) as Map<String, dynamic>);

        shoppingListMap.forEach((id, valueMap) {
          groceries.add(
            GroceryItem.toObject(id, valueMap),
          );
        });
      }
      return {'groceries': groceries};
    }).catchError((error) => error);
  }
}
