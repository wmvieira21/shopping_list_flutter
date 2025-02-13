import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/enum/categories.dart';
import 'package:shopping_list/models/category.dart';

class GroceryItem {
  const GroceryItem(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.category});

  final String id;
  final String name;
  final int quantity;
  final Category category;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category.name,
    };
  }

  factory GroceryItem.toObject(String id, dynamic valuesMap) {
    return GroceryItem(
        id: id,
        name: valuesMap['name'],
        quantity: valuesMap['quantity'],
        category: categoriesData[Categories.values
            .byName(valuesMap['category'].toString().toLowerCase())]!);
  }
}
