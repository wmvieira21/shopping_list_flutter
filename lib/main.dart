import 'package:flutter/material.dart';
import 'package:shopping_list/grocery_home_page.dart';

ThemeData theme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromRGBO(75, 73, 73, 0.922),
    brightness: Brightness.dark,
    surface: Color.fromRGBO(34, 34, 34, 1),
  ),
  scaffoldBackgroundColor: Color.fromRGBO(34, 34, 34, 0.925),
);

void main() {
  runApp(
    MaterialApp(
      theme: theme,
      home: SafeArea(
        child: GroceryHomePage(),
      ),
    ),
  );
}
