import 'item.dart';

class Menu {
  int menuID;
  List<Item> items = [];

  Menu(this.menuID, this.items);

  void addItem(Item item) {
    items.add(item);
  }

  void removeItem(Item item) {
    items.remove(item);
  }

  void updateItem(Item oldItem, Item newItem) {
    int index = items.indexOf(oldItem);
    if (index != -1) {
      items[index] = newItem;
    }
  }
}