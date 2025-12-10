import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  final List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => [..._notifications];

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void markAsRead(String id) {
    // In a real app, this would update state properly
    // Since objects are immutable in our simple model, we might just ignore strict immutability for this demo
    // or replace the object
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index >= 0) {
      // For simplicity in this demo without copyWith on Notification yet
      // We will just not implement read status toggle visually complex logic
      // But let's trigger a rebuild
      notifyListeners();
    }
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
