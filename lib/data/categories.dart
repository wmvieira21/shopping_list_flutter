import 'package:flutter/material.dart';
import 'package:shopping_list/enum/categories.dart';
import 'package:shopping_list/models/category.dart';

const categoriesData = {
  Categories.vegetables: Category(name: 'Vegetables', color: Colors.green),
  Categories.fruit: Category(name: 'Fruit', color: Colors.orange),
  Categories.meat: Category(name: 'Meat', color: Colors.red),
  Categories.dairy: Category(name: 'Dairy', color: Colors.yellow),
  Categories.carbs: Category(name: 'Carbs', color: Colors.brown),
};
