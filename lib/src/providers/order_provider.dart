import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/database_helper.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;

  List<Order> get orders => [..._orders];
  bool get isLoading => _isLoading;

  OrderProvider() {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();
    try {
      _orders = await DatabaseHelper.instance.getOrders();
    } catch (e) {
      debugPrint('Error fetching orders: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addOrder(Order order) async {
    try {
      await DatabaseHelper.instance.addOrder(order);
      _orders.insert(0, order);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding order: $e');
      rethrow;
    }
  }
}
