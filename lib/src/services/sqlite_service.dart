import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data_service.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class SqliteService implements DataService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('wcdonalds.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const realType = 'REAL';

    // Users Table (Existing)
    await db.execute('''
CREATE TABLE users (
  id $idType,
  email $textType NOT NULL UNIQUE,
  password $textType NOT NULL,
  name $textType NOT NULL,
  phone $textType,
  address $textType,
  avatar_url $textType
)
''');

    // Products Table
    await db.execute('''
CREATE TABLE products (
  id $textType PRIMARY KEY,
  name $textType NOT NULL,
  description $textType,
  price $realType NOT NULL,
  imageUrl $textType,
  category $textType,
  allowedAddOns $textType
)
''');

    // Orders Table
    await db.execute('''
CREATE TABLE orders (
  id $textType PRIMARY KEY,
  totalAmount $realType NOT NULL,
  date $textType NOT NULL,
  status $textType NOT NULL,
  items $textType NOT NULL
)
''');

    // Seed Products
    await _seedProducts(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      const textType = 'TEXT';
      const realType = 'REAL';

      await db.execute('''
CREATE TABLE products (
  id $textType PRIMARY KEY,
  name $textType NOT NULL,
  description $textType,
  price $realType NOT NULL,
  imageUrl $textType,
  category $textType,
  allowedAddOns $textType
)
''');

      await db.execute('''
CREATE TABLE orders (
  id $textType PRIMARY KEY,
  totalAmount $realType NOT NULL,
  date $textType NOT NULL,
  status $textType NOT NULL,
  items $textType NOT NULL
)
''');

      await _seedProducts(db);
    }
  }

  Future<void> _seedProducts(Database db) async {
    final batch = db.batch();
    for (var p in mockProducts) {
      batch.insert(
        'products',
        _productToMap(p),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit();
  }

  // --- Helpers for Serialization ---

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
      final List<dynamic> jsonList = jsonDecode(map['allowedAddOns']);
      addons = jsonList.map((a) => AddOn(name: a['name'], price: a['price'])).toList();
    }
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      category: map['category'],
      allowedAddOns: addons,
    );
  }

  Map<String, dynamic> _orderToMap(Order o) {
    // Serialize Items
    final itemsJson = o.items.map((item) {
      return {
        'productId': item.product.id,
        // We embed full product snapshot to preserve history if product changes,
        // or just ID if we assume consistency. Let's embed full snapshot for safety.
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
      'status': o.status.name, // Enum to string
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
      totalAmount: map['totalAmount'],
      date: DateTime.parse(map['date']),
      status: OrderStatus.values.firstWhere((e) => e.name == map['status'], orElse: () => OrderStatus.pending),
    );
  }

  // --- Implementation of DataService ---

  // USER
  @override
  Future<User> createUser(User user) async {
    final db = await database;
    final id = await db.insert('users', user.toMap());
    return user.copyWith(id: id);
  }

  @override
  Future<User?> readUser(int id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> updateUser(User user) async {
    final db = await database;
    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // PRODUCT
  @override
  Future<List<Product>> getProducts() async {
    final db = await database;
    final maps = await db.query('products');

    if (maps.isEmpty) {
        // Double check seeding if empty? No, handled in onCreate/onUpgrade
        return [];
    }

    return maps.map((m) => _mapToProduct(m)).toList();
  }

  @override
  Future<void> addProduct(Product product) async {
    final db = await database;
    await db.insert('products', _productToMap(product), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update(
      'products',
      _productToMap(product),
      where: 'id = ?',
      whereArgs: [product.id]
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    final db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  // ORDER
  @override
  Future<List<Order>> getOrders() async {
    final db = await database;
    final maps = await db.query('orders', orderBy: 'date DESC');
    return maps.map((m) => _mapToOrder(m)).toList();
  }

  @override
  Future<void> addOrder(Order order) async {
    final db = await database;
    await db.insert('orders', _orderToMap(order));
  }
}
