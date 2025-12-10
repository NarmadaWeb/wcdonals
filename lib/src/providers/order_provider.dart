import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(Order order) {
    _orders.insert(0, order); // Add to top
    notifyListeners();
  }
}
