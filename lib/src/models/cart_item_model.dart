import 'product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  final String? size; // 'Reguler', 'Large'
  final List<String> addOns;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.size,
    this.addOns = const [],
  });

  double get totalPrice {
    double base = product.price;
    if (size == 'Large') base += 5000;
    // Add logic for add-ons pricing if needed
    for (var addon in addOns) {
        if (addon == 'Ekstra Keju') base += 3000;
        // Pickle is free
    }
    return base * quantity;
  }
}
