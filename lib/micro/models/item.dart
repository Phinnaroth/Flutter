class Item {
  int itemID;
  String name;
  double price;

  Item(this.itemID, this.name, this.price);

  void updatePrice(double newPrice) {
    price = newPrice;
  }
}