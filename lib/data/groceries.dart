import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/enum/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';

final List<GroceryItem> groceriesItemsData = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categoriesData[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Steak',
      quantity: 1,
      category: categoriesData[Categories.meat]!),
  GroceryItem(
      id: 'c',
      name: 'Apple',
      quantity: 1,
      category: categoriesData[Categories.fruit]!),
  GroceryItem(
      id: 'd',
      name: 'Bread',
      quantity: 1,
      category: categoriesData[Categories.carbs]!),
];
