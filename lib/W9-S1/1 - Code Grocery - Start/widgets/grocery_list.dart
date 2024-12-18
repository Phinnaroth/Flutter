import 'package:flutter/material.dart';
import '../data/dummy_items.dart';
import '../models/grocery_item.dart';
import '../models/mode.dart';
import 'new_item.dart';


class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  final List<GroceryItem> _groceryItem = dummyGroceryItems;
 
  void onAdd() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem(mode: Mode.creating,)),
    );
    if (newItem != null){
      setState(() {
        _groceryItem.add(newItem);
      });
    }
  }

  void onEdit(GroceryItem item, int index)  async{
    final updateItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => NewItem(editedItem: item, mode: Mode.editing,)),
    );
    if (updateItem != null){
      setState(() {
        _groceryItem[index] = updateItem;

        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (ctx, index) => GroceryTile(
          dummyGroceryItems[index],
          () => onEdit(_groceryItem[index], index)
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile(this.groceryItem, this.onEdit,{super.key});

  final GroceryItem groceryItem;
  final VoidCallback onEdit;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(groceryItem.name),
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
      onTap: onEdit,
    );
  }
}


