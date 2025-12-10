import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../services/database_helper.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userId')) return false;

    final userId = prefs.getInt('userId');
    if (userId == null) return false;

    final user = await DatabaseHelper.instance.readUser(userId);
    if (user != null) {
      _user = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await DatabaseHelper.instance.login(email, password);
      if (user != null) {
        _user = user;
        final prefs = await SharedPreferences.getInstance();
        if (user.id != null) {
          await prefs.setInt('userId', user.id!);
        }
        notifyListeners();
        return true;
      }
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateAvatar(String path) async {
     if (_user != null) {
      final updatedUser = _user!.copyWith(avatarUrl: path);
      // We are just updating the local state and database here.
      // Ideally we would upload to a server, but requirement says "local only".
      // Since the User model likely maps to DB columns, we might need to store the local path in DB
      // or just treat the 'avatarUrl' field as a local path if it doesn't start with http.

      await updateProfile(updatedUser);

      // Also save to shared prefs for redundancy if needed, but DB is better.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('local_avatar_path_${_user!.id}', path);
     }
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    try {
      final newUser = User(
        name: name,
        email: email,
        password: password,
        avatarUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBzyfQVVKwbO5o7_ypesxxwfOs3hxhewjJCwsKs-ol3bE7AGm1igakeCBFScMbtTUFNesJc1RBsn8YcHjmvhk6l0kYgdZeO_8eUVszjsJQ9zBuGYiQBOkbRR7B_UiFYfv8wd88NnK6c8vTQdQoBkqYLJZdGIaFuy14Uo21uO-RtTj4ImbZPd6EG5gu6RKn5wyNqJ4aiaH91dsq8FHYszUQ80nONXgK4wZl_O8BtHHD_SglH7AF5Dz1yMUFDCT6IdA0QPesJpIY4tg', // Default avatar
      );
      _user = await DatabaseHelper.instance.createUser(newUser);

      final prefs = await SharedPreferences.getInstance();
      if (_user?.id != null) {
        await prefs.setInt('userId', _user!.id!);
      }

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

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
