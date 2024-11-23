import '../models/restaurant.dart';

class ConsoleCLI {


  void displayCustomers(Restaurant restaurant) {
    print('Customers:');
    restaurant.customers.forEach((cust) => print('ID: ${cust.customerID}, Name: ${cust.name}'));
  }

  void displayOrders(Restaurant restaurant) {
    print('Orders:');
    restaurant.orders.forEach((order) => print('Order ID: ${order.orderID}, Total: \$${order.calculateTotal()}'));
  }

  void displayReservations(Restaurant restaurant) {
    print('Reservations:');
    restaurant.reservations.forEach((res) => print('Reservation ID: ${res.reservationID}, Table: ${res.tableNumber}'));
  }
}