import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

abstract class DataService {
  // User Operations
  Future<User?> login(String email, String password);
  Future<User> createUser(User user);
  Future<User?> readUser(int id);
  Future<int> updateUser(User user);

  // Product Operations
  Future<List<Product>> getProducts();
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);

  // Order Operations
  Future<List<Order>> getOrders();
  Future<void> addOrder(Order order);
}
