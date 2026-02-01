import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/database_helper.dart';

class MenuProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => [..._products];
  bool get isLoading => _isLoading;

  MenuProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _products = await DatabaseHelper.instance.getProducts();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.addProduct(product);
      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.updateProduct(product);
      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteProduct(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.deleteProduct(id);
      await fetchProducts();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
