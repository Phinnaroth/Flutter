import 'package:flutter/material.dart';
import '../models/grocery_category.dart';
import '../models/grocery_item.dart';

enum Mode { creating, editing , normal , selection}

class NewItem extends StatefulWidget {
  final Mode mode;
  final GroceryItem? existingItem;
  const NewItem({super.key, required this.mode, this.existingItem});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();

  String _enteredName = '';
  int _enteredQuantity = 1;
  GroceryCategory _selectedCategory = GroceryCategory.fruit;

  @override
  void initState() {
    super.initState();
    if (widget.mode == Mode.editing && widget.existingItem != null) {
      _enteredName = widget.existingItem!.name;
      _enteredQuantity = widget.existingItem!.quantity;
      _selectedCategory = widget.existingItem!.category;
    }
  }

  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      final newItem = GroceryItem(
        name: _enteredName,
        quantity: _enteredQuantity,
        category: _selectedCategory,
        id: widget.existingItem?.id ?? 'item-${DateTime.now().toString()}',
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

  String? validateQuantity(String? value) {
    if (value == null ||
        value.isEmpty ||
        int.tryParse(value) == null ||
        int.parse(value) <= 0) {
      return 'Must be a valid, positive number.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == Mode.editing ? 'Edit Item' : 'Add a new item'),
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
                  labelText: 'Name',
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
                        labelText: 'Quantity',
                      ),
                      initialValue: _enteredQuantity.toString(),
                      validator: validateQuantity,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<GroceryCategory>(
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                      value: _selectedCategory,
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
                        setState(() {
                          _selectedCategory = value!;
                        });
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
                    child: Text(widget.mode == Mode.editing ? 'Save Changes' : 'Add Item'),
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
