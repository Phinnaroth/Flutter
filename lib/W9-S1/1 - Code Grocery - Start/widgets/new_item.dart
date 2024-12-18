import 'package:flutter/material.dart';
import 'package:myproject/W9-S1/1%20-%20Code%20Grocery%20-%20Start/models/grocery_item.dart';
import '../models/grocery_category.dart';
import '../models/mode.dart';

class NewItem extends StatefulWidget {
   final Mode mode;
   final GroceryItem? editedItem;


  const NewItem({super.key, required this.mode, this.editedItem});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  // We create a key to access and control the state of the Form.
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredQuantity = 1;
  GroceryCategory _selectedCatgory = GroceryCategory.fruit;

  void _saveItem() {
    // 1 - Validate the form
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      // 2 - Save the form to get last entered values
      _formKey.currentState!.save();


    final enterName = _enteredName;
    final enterQty = _enteredQuantity;
    final enterCategory = _selectedCatgory;

    

    GroceryItem newItem = GroceryItem(
          id: 'item-${DateTime.now().toString()}', 
          name: enterName, 
          quantity: enterQty, 
          category: enterCategory
        );
      
      Navigator.of(context).pop(newItem);
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  String? validateTitle(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  // TODO: validate quantity
  String? validateQuantity(String? quantity) {
  if (quantity == null || 
      quantity.isEmpty || 
      int.tryParse(quantity) == null || 
      int.tryParse(quantity)! <= 0) {
    return 'Must be a valid, positive number';
  }
  return null;
}

bool get isEditing => widget.mode == Mode.editing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == Mode.creating ? 'Add a new item' : 'Edit item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                initialValue: _enteredName,
                validator: validateTitle,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _enteredQuantity.toString(),
                      validator: validateQuantity,
                      onSaved: (quantity) {
                        _enteredQuantity = int.parse(quantity!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      value: _selectedCatgory,
                      items: [
                        for (final category in GroceryCategory.values)
                          DropdownMenuItem<GroceryCategory>(

                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                ),
                                const SizedBox(width: 6),
                                Text(category.label),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        _selectedCatgory = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetForm,
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text(widget.mode == Mode.creating ? 'Add' : 'Edit'),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
