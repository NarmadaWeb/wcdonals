import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_service.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class JsonService implements DataService {
  static const String _usersKey = 'wcdonalds_users';
  static const String _productsKey = 'wcdonalds_products';
  static const String _ordersKey = 'wcdonalds_orders';

  // --- Serialization Helpers (Duplicated to avoid coupling) ---

  Map<String, dynamic> _productToMap(Product p) {
    return {
      'id': p.id,
      'name': p.name,
      'description': p.description,
      'price': p.price,
      'imageUrl': p.imageUrl,
      'category': p.category,
      'allowedAddOns': jsonEncode(p.allowedAddOns.map((a) => {'name': a.name, 'price': a.price}).toList()),
    };
  }

  Product _mapToProduct(Map<String, dynamic> map) {
    List<AddOn> addons = [];
    if (map['allowedAddOns'] != null) {
      // allowedAddOns is stored as JSON string inside the map because of SQLite compatibility
      // But in pure JSON storage, we might store it as a List directly?
      // To keep consistent with the Map structure we defined in SqliteService (where we use jsonEncode on the list),
      // we will respect that structure.

      final List<dynamic> jsonList = (map['allowedAddOns'] is String)
          ? jsonDecode(map['allowedAddOns'])
          : map['allowedAddOns']; // Handle case if it was stored as list

      addons = jsonList.map((a) => AddOn(name: a['name'], price: a['price'])).toList();
    }
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
      category: map['category'],
      allowedAddOns: addons,
    );
  }

  Map<String, dynamic> _orderToMap(Order o) {
    final itemsJson = o.items.map((item) {
      return {
        'productId': item.product.id,
        'productSnapshot': _productToMap(item.product),
        'quantity': item.quantity,
        'size': item.size,
        'addOns': item.addOns,
      };
    }).toList();

    return {
      'id': o.id,
      'totalAmount': o.totalAmount,
      'date': o.date.toIso8601String(),
      'status': o.status.name,
      'items': jsonEncode(itemsJson),
    };
  }

  Order _mapToOrder(Map<String, dynamic> map) {
    final List<dynamic> itemsJson = jsonDecode(map['items']);
    final items = itemsJson.map((itemMap) {
      final productMap = itemMap['productSnapshot'];
      return CartItem(
        product: _mapToProduct(productMap),
        quantity: itemMap['quantity'],
        size: itemMap['size'],
        addOns: List<String>.from(itemMap['addOns']),
      );
    }).toList();

    return Order(
      id: map['id'],
      items: items,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      date: DateTime.parse(map['date']),
      status: OrderStatus.values.firstWhere((e) => e.name == map['status'], orElse: () => OrderStatus.pending),
    );
  }

  // --- Internal Storage Helpers ---

  Future<List<Map<String, dynamic>>> _readList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    final List<dynamic> list = jsonDecode(jsonString);
    return list.cast<Map<String, dynamic>>();
  }

  Future<void> _writeList(String key, List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(list));
  }

  // --- Implementation ---

  // USER
  @override
  Future<User> createUser(User user) async {
    final users = await _readList(_usersKey);
    // Generate ID
    int maxId = 0;
    for (var u in users) {
      if (u['id'] != null && u['id'] > maxId) maxId = u['id'];
    }
    final newId = maxId + 1;
    final newUser = user.copyWith(id: newId);

    users.add(newUser.toMap());
    await _writeList(_usersKey, users);
    return newUser;
  }

  @override
  Future<User?> readUser(int id) async {
    final users = await _readList(_usersKey);
    try {
      final userMap = users.firstWhere((u) => u['id'] == id);
      return User.fromMap(userMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    final users = await _readList(_usersKey);
    try {
      final userMap = users.firstWhere((u) => u['email'] == email && u['password'] == password);
      return User.fromMap(userMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<int> updateUser(User user) async {
    final users = await _readList(_usersKey);
    final index = users.indexWhere((u) => u['id'] == user.id);
    if (index != -1) {
      users[index] = user.toMap();
      await _writeList(_usersKey, users);
      return 1;
    }
    return 0;
  }

  // PRODUCT
  @override
  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_productsKey)) {
      // Seed
      final seededMaps = mockProducts.map((p) => _productToMap(p)).toList();
      await _writeList(_productsKey, seededMaps);
      return mockProducts;
    }

    final maps = await _readList(_productsKey);
    return maps.map((m) => _mapToProduct(m)).toList();
  }

  @override
  Future<void> addProduct(Product product) async {
    // Ensure initialized
    if (!(await SharedPreferences.getInstance()).containsKey(_productsKey)) {
       await getProducts();
    }

    final products = await _readList(_productsKey);
    // Replace if exists, else add
    final index = products.indexWhere((p) => p['id'] == product.id);
    final map = _productToMap(product);
    if (index != -1) {
      products[index] = map;
    } else {
      products.add(map);
    }
    await _writeList(_productsKey, products);
  }

  @override
  Future<void> updateProduct(Product product) async {
    await addProduct(product); // Same logic
  }

  @override
  Future<void> deleteProduct(String id) async {
    final products = await _readList(_productsKey);
    products.removeWhere((p) => p['id'] == id);
    await _writeList(_productsKey, products);
  }

  // ORDER
  @override
  Future<List<Order>> getOrders() async {
    final maps = await _readList(_ordersKey);
    // Sort desc date
    final orders = maps.map((m) => _mapToOrder(m)).toList();
    orders.sort((a, b) => b.date.compareTo(a.date));
    return orders;
  }

  @override
  Future<void> addOrder(Order order) async {
    final orders = await _readList(_ordersKey);
    orders.add(_orderToMap(order));
    await _writeList(_ordersKey, orders);
  }
}
