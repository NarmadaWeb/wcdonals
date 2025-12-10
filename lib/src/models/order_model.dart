import 'cart_item_model.dart';

enum OrderStatus {
  pending,
  processing,
  completed,
  cancelled
}

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime date;
  final OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.date,
    this.status = OrderStatus.pending,
  });
}
