import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import 'new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = dummyGroceryItems;
  final Set<GroceryItem> _selectedItems = {};  // Track selected items
  Mode _mode = Mode.normal;  // Default mode is normal

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(mode: Mode.creating),
      ),
    );

    if (newItem != null) {
      setState(() {
        _groceryItems.add(newItem);
      });
    }
  }

  void _editItem(GroceryItem item) async {
    final updatedItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => NewItem(
          mode: Mode.editing,
          existingItem: item,
        ),
      ),
    );

    if (updatedItem != null) {
      setState(() {
        final index = _groceryItems.indexWhere((g) => g.id == item.id);
        if (index != -1) {
          _groceryItems[index] = updatedItem;
        }
      });
    }
  }

  void _toggleSelectionMode() {
    setState(() {
      _mode = _mode == Mode.selection ? Mode.normal : Mode.selection;
    });
  }

  void _toggleSelection(GroceryItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });
  }

  void _removeSelectedItems() {
    setState(() {
      _groceryItems.removeWhere((item) => _selectedItems.contains(item));
      _selectedItems.clear();
      _mode = Mode.normal;
    });
  }

  // Function to handle reordering of items
  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _groceryItems.removeAt(oldIndex);
      _groceryItems.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    // Use ReorderableListView when in normal mode
    if (_groceryItems.isNotEmpty) {
      if (_mode == Mode.normal) {
        content = ReorderableListView(
          onReorder: _onReorder,
          children: [
            for (final item in _groceryItems)
              GroceryTile(
                key: Key(item.id),
                groceryItem: item,
                onTap: () {
                  if (_mode == Mode.selection) {
                    _toggleSelection(item);
                  } else {
                    _editItem(item);
                  }
                },
                isSelected: _selectedItems.contains(item),
                onLongPress: _mode == Mode.normal ? _toggleSelectionMode : null,
                onCheckboxChanged: _mode == Mode.selection
                    ? (value) => _toggleSelection(item)
                    : null,
              ),
          ],
        );
      } else {
        content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) {
            final item = _groceryItems[index];
            return GroceryTile(
              groceryItem: item,
              onTap: () {
                if (_mode == Mode.selection) {
                  _toggleSelection(item);
                } else {
                  _editItem(item);
                }
              },
              isSelected: _selectedItems.contains(item),
              onLongPress: _mode == Mode.normal ? _toggleSelectionMode : null,
              onCheckboxChanged: _mode == Mode.selection
                  ? (value) => _toggleSelection(item)
                  : null,
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_mode == Mode.selection
            ? 'Selected: ${_selectedItems.length}'
            : 'Your Groceries'),
        leading: _mode == Mode.selection
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    _mode = Mode.normal;  // Exit selection mode
                    _selectedItems.clear();
                  });
                },
              )
            : null,
        actions: [
          if (_mode == Mode.selection)
            IconButton(
              onPressed: _removeSelectedItems,
              icon: const Icon(Icons.delete),
            ),
          if (_mode == Mode.normal)
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({
    required this.groceryItem,
    required this.onTap,
    this.isSelected = false,
    this.onLongPress,
    this.onCheckboxChanged,
    super.key,
  });

  final GroceryItem groceryItem;
  final VoidCallback onTap;
  final bool isSelected;
  final VoidCallback? onLongPress;
  final ValueChanged<bool?>? onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(groceryItem.name),
      leading: _getLeadingWidget(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(groceryItem.quantity.toString()),  // Display the quantity
          const SizedBox(width: 20),  // Add space between the quantity and icon
        ],
      ),
      onTap: onTap,
      onLongPress: onLongPress,
    );
  }

  Widget _getLeadingWidget() {
    return _getCheckbox();
  }

  Widget _getCheckbox() {
    if (onCheckboxChanged != null) {
      return Checkbox(
        value: isSelected,
        onChanged: onCheckboxChanged,
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        color: groceryItem.category.color,
      );
    }
  }
}
