import 'package:myproject/micro/models/customer.dart';
import 'package:myproject/micro/models/item.dart';
import 'package:myproject/micro/models/menu.dart';
import 'package:myproject/micro/models/order.dart';
import 'package:myproject/micro/models/singleTableReservation.dart';

class Restaurant {
  late Menu menu;
  List<Customer> customers = [];
  List<Order> orders = [];
  List<SingleTableReservation> reservations = [];
  List<String> tableNumbers =['T001', 'T002', 'T003', 'T004', 'T005', 'T006', 'T007', 'T008', 'T009', 'T010'];

  Restaurant(this.menu);

  void displayMenu(Restaurant restaurant) {
    print('Menu:');
    for (var item in menu.items) {
      print('Item ID: ${item.itemID}, Name: ${item.name},  Price: \$${item.price}');
    }
  }

  void addCustomer(int customerID, String name, String contactDetails) {
    customers.add(Customer(customerID, name, contactDetails));
  }

  void listCustomer() {
    customers.forEach((cust) => print("Customer ID: ${cust.customerID}, Name: ${cust.name}"));
  }

  void placeOrder(int customerID, List<int> itemIDs) {
    customers.firstWhere((cust) => cust.customerID == customerID);

    List<Item> orderItems = menu.items.where((item) => itemIDs.contains(item.itemID)).toList();
    Order order = Order(orders.length + 1, customerID, OrderStatus.pending, orderItems, PaymentStatus.unpaid);
    orders.add(order);
  }

  void addReservation(int customerID, String tableNumber, DateTime reservationTime, int numberOfGuests) {
    reservations.add(SingleTableReservation(
        reservations.length + 1, customerID, tableNumber, reservationTime, numberOfGuests));
  }

  void updateReservation(SingleTableReservation oldReservation, SingleTableReservation newReservation) {
    int index = reservations.indexOf(oldReservation);
    if (index != -1) reservations[index] = newReservation;
  }

  void removeReservation(SingleTableReservation reservation) {
    reservations.remove(reservation);
  }

}