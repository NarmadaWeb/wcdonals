import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cart.items.isEmpty
        ? const Center(child: Text('Keranjang kosong'))
        : Column(
            children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: cart.items.length + 1, // +1 for "Add More Items" button
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                            if (index == cart.items.length) {
                                return TextButton(
                                    onPressed: () => Navigator.pop(context), // Go back to shop
                                    child: Row(
                                        children: [
                                             Icon(Icons.add, color: Theme.of(context).primaryColor),
                                             const SizedBox(width: 8),
                                             Text('Tambah Item Lain', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                                        ],
                                    ),
                                );
                            }

                            final item = cart.items[index];
                            return Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                    children: [
                                        Container(
                                            width: 64,
                                            height: 64,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12),
                                                image: DecorationImage(
                                                    image: NetworkImage(item.product.imageUrl),
                                                    fit: BoxFit.cover,
                                                )
                                            ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Text(
                                                        item.product.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                    ),
                                                    Text(
                                                        'Rp ${item.totalPrice.toStringAsFixed(0)}',
                                                        style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                                                    ),
                                                    if (item.size != null)
                                                        Text('${item.size}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                                ],
                                            ),
                                        ),
                                        Row(
                                            children: [
                                                _qtyBtn(context, Icons.remove, () => cart.decrementQuantity(index)),
                                                SizedBox(
                                                    width: 32,
                                                    child: Text('${item.quantity}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                                                ),
                                                _qtyBtn(context, Icons.add, () => cart.incrementQuantity(index)),
                                            ],
                                        )
                                    ],
                                ),
                            );
                        },
                    ),
                ),
                Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                        ]
                    ),
                    child: Column(
                        children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                                    Text('Rp ${cart.subtotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                            ),
                            const SizedBox(height: 12),
                             Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    const Text('Total Pembayaran', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                    Text('Rp ${cart.subtotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    onPressed: () {
                                        Navigator.pushNamed(context, '/payment');
                                    },
                                    child: const Text('Lanjutkan ke Pembayaran', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                ),
                            )
                        ],
                    ),
                )
            ],
        ),
    );
  }

  Widget _qtyBtn(BuildContext context, IconData icon, VoidCallback onTap) {
      return GestureDetector(
          onTap: onTap,
          child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: Colors.black),
          ),
      );
  }
}
