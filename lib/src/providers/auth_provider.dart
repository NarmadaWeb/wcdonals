import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/database_helper.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await DatabaseHelper.instance.login(email, password);
      if (user != null) {
        _user = user;
        notifyListeners();
        return true;
      }
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    try {
      final newUser = User(
        name: name,
        email: email,
        password: password,
        avatarUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBzyfQVVKwbO5o7_ypesxxwfOs3hxhewjJCwsKs-ol3bE7AGm1igakeCBFScMbtTUFNesJc1RBsn8YcHjmvhk6l0kYgdZeO_8eUVszjsJQ9zBuGYiQBOkbRR7B_UiFYfv8wd88NnK6c8vTQdQoBkqYLJZdGIaFuy14Uo21uO-RtTj4ImbZPd6EG5gu6RKn5wyNqJ4aiaH91dsq8FHYszUQ80nONXgK4wZl_O8BtHHD_SglH7AF5Dz1yMUFDCT6IdA0QPesJpIY4tg', // Default avatar
      );
      _user = await DatabaseHelper.instance.createUser(newUser);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateProfile(User updatedUser) async {
    _setLoading(true);
    try {
      await DatabaseHelper.instance.updateUser(updatedUser);
      _user = updatedUser;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
