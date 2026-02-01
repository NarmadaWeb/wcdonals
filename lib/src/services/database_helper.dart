import 'package:flutter/foundation.dart';
import 'data_service.dart';
import 'sqlite_service.dart';
import 'json_service.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class DatabaseHelper implements DataService {
  static final DatabaseHelper instance = DatabaseHelper._init();

  late final DataService _service;

  DatabaseHelper._init() {
    if (kIsWeb) {
      _service = JsonService();
    } else {
      _service = SqliteService();
    }
  }

  @override
  Future<User> createUser(User user) => _service.createUser(user);

  @override
  Future<User?> readUser(int id) => _service.readUser(id);

  @override
  Future<User?> login(String email, String password) => _service.login(email, password);

  @override
  Future<int> updateUser(User user) => _service.updateUser(user);

  @override
  Future<List<Product>> getProducts() => _service.getProducts();

  @override
  Future<void> addProduct(Product product) => _service.addProduct(product);

  @override
  Future<void> updateProduct(Product product) => _service.updateProduct(product);

  @override
  Future<void> deleteProduct(String id) => _service.deleteProduct(id);

  @override
  Future<List<Order>> getOrders() => _service.getOrders();

  @override
  Future<void> addOrder(Order order) => _service.addOrder(order);
}
