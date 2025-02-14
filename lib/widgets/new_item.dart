import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/enum/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/services/grocery_service.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  final GroceryService groceryService = GroceryService();
  String _enteredName = '';
  int _enteredQuantity = 1;
  Category _selectedCategory = categoriesData[Categories.carbs]!;
  bool _isSending = false;

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      _formKey.currentState!.save();

      GroceryItem item = GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory);

      groceryService.groceryItemPost(item).then((response) {
        final responseBody = jsonDecode(response.body);
        if (!context.mounted) {
          return;
        }

        Navigator.of(context).pop(
          GroceryItem(
              id: responseBody['name'],
              name: _enteredName,
              quantity: _enteredQuantity,
              category: _selectedCategory),
        );
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("An error has occured: ${e.toString()}"),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Name'),
                ),
                maxLength: 50,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Must be a valid.';
                  }
                  return null;
                },
                onSaved: (newValue) => _enteredName = newValue!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number.';
                        }
                        return null;
                      },
                      onSaved: (newValue) =>
                          _enteredQuantity = int.parse(newValue!),
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: categoriesData.entries
                            .map(
                              (category) => DropdownMenuItem(
                                value: category.value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(spacing: 10, children: [
                                    ColoredBox(
                                      color: category.value.color,
                                      child: SizedBox(
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                    Text(category.value.name),
                                  ]),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {});
                          _selectedCategory = value!;
                        }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () => _formKey.currentState!.reset(),
                    child: Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _onSave,
                    child: _isSending
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text("Add Item"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
