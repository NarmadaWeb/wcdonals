import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/order_provider.dart';
import '../providers/notification_provider.dart';
import '../models/order_model.dart';
import '../models/notification_model.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final user = Provider.of<AuthProvider>(context).user;
    final double shippingCost = 12000;
    final double total = cart.subtotal + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Alamat Pengiriman',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Rumah - ${user?.name ?? ''}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(user?.address ?? 'Alamat belum diatur',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(user?.phone ?? '-',
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            minimumSize: const Size(60, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: const Text('Ubah',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Ringkasan Pesanan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        ...cart.items
                            .map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    item.product.imageUrl),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                            '${item.product.name} (x${item.quantity})',
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                          'Rp ${item.totalPrice.toStringAsFixed(0)}'),
                                    ],
                                  ),
                                ))
                            .toList(),
                        const Divider(),
                        _summaryRow('Subtotal',
                            'Rp ${cart.subtotal.toStringAsFixed(0)}'),
                        const SizedBox(height: 8),
                        _summaryRow('Biaya Pengiriman',
                            'Rp ${shippingCost.toStringAsFixed(0)}'),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Pembayaran',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Rp ${total.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Metode Pembayaran',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.account_balance_wallet,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('WcPay',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Saldo: Rp 100.000',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                            minimumSize: const Size(60, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: const Text('Ubah',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5))
            ]),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total Pembayaran',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text('Rp ${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        // Create Order
                        final order = Order(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          items: List.from(cart.items),
                          totalAmount: total,
                          date: DateTime.now(),
                          status: OrderStatus.pending,
                        );

                        // Add to Order History
                        Provider.of<OrderProvider>(context, listen: false)
                            .addOrder(order);

                        // Add Notification
                        Provider.of<NotificationProvider>(context, listen: false)
                            .addNotification(AppNotification(
                              id: DateTime.now().toString(),
                              title: 'Pesanan Berhasil',
                              message: 'Pesanan #${order.id} berhasil dibuat dan sedang diproses.',
                              date: DateTime.now()
                            ));

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.check,
                                      color: Colors.green, size: 48),
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  'Pesanan Berhasil!',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Terima kasih telah memesan di WcDonalds. Makananmu akan segera disiapkan.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      cart.clearCart();
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/home', (route) => false);
                                    },
                                    child: const Text('Kembali ke Beranda'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text('Bayar Sekarang',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
