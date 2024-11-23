import 'item.dart';

enum OrderStatus { pending, completed, inProgress, cancelled }
enum PaymentStatus { unpaid, paid, refunded }

class Order {
  int orderID;
  int customerID;
  List<Item> orderItems = [];
  OrderStatus orderStatus;
  PaymentStatus paymentStatus;

  Order(this.orderID, this.customerID, this.orderStatus, this.orderItems, this.paymentStatus);

  double calculateTotal() {
    return orderItems.fold(0.0, (sum, item) => sum + item.price);
  }
}