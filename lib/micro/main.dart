import 'package:myproject/micro/cli/consoleCLI.dart';
import 'package:myproject/micro/models/item.dart';
import 'package:myproject/micro/models/menu.dart';
import 'package:myproject/micro/models/restaurant.dart';
import 'package:myproject/micro/utils/persistenceManager.dart';


void main() {

  Menu menu = Menu(1, [
    Item(1, 'Pizza', 10.99),
    Item(2, 'Burger', 5.99),
    Item(3, 'Pasta', 9.99),
  ]);


  Restaurant restaurant = Restaurant(menu);
  ConsoleCLI cli = ConsoleCLI();
  PersistenceManager persistenceManager = PersistenceManager();

  restaurant.displayMenu(restaurant);
  restaurant.addCustomer(1, 'Phinnaroth', 'naroth@gmail.com');
  restaurant.addCustomer(2, 'Punloue', 'punloue@gmail.com');
  
  restaurant.placeOrder(1, [1, 2]);
  cli.displayOrders(restaurant);

  restaurant.addReservation(2, 'T002', DateTime(2024, 11, 23, 17, 30), 3);
  cli.displayReservations(restaurant);


  persistenceManager.saveToJson(restaurant, 'restaurant.json');
}