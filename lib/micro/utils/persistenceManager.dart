import 'dart:convert';
import '../models/restaurant.dart';
import 'dart:io';

class PersistenceManager {
  void saveToJson(Restaurant restaurant, String filePath) {
    Map<String, dynamic> data = {
      "menu": restaurant.menu.items.map((item) => {
            "id": item.itemID,
            "name": item.name,
            "price": item.price,
          }).toList(),
      "customers": restaurant.customers.map((cust) => {
            "id": cust.customerID,
            "name": cust.name,
            "contact": cust.contactDetails,
          }).toList(),
      "orders": restaurant.orders.map((order) => {
            "id": order.orderID,
            "customerID": order.customerID,
            "total": order.calculateTotal(),
            "status": order.orderStatus.toString(),
          }).toList(),
      "reservations": restaurant.reservations.map((res) => {
            "id": res.reservationID,
            "customerID": res.customerID,
            "table": res.tableNumber,
            "time": res.reservationTime.toIso8601String(),
          }).toList(),
    };

    File(filePath).writeAsStringSync(jsonEncode(data));
  }

  Restaurant loadFromJson(String filePath) {
    // Load and parse data
    // Build a Restaurant instance from the data
    // (Logic here would depend on the JSON structure)
    throw UnimplementedError("Load functionality not implemented yet.");
  }
}