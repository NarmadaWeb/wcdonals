import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../models/order_model.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final orders = orderProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum ada pesanan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Yuk pesan makanan favoritmu sekarang!',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/menu');
                    },
                    child: const Text('Lihat Menu'),
                  )
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order);
              },
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    Color statusColor;
    String statusText;

    switch (order.status) {
      case OrderStatus.pending:
        statusColor = Colors.orange;
        statusText = 'Menunggu Konfirmasi';
        break;
      case OrderStatus.processing:
        statusColor = Colors.blue;
        statusText = 'Sedang Disiapkan';
        break;
      case OrderStatus.completed:
        statusColor = Colors.green;
        statusText = 'Selesai';
        break;
      case OrderStatus.cancelled:
        statusColor = Colors.red;
        statusText = 'Dibatalkan';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMM yyyy, HH:mm').format(order.date),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...order.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                     Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(item.product.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          Text('${item.quantity}x  @ Rp ${item.product.price.toStringAsFixed(0)}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Pesanan',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                'Rp ${order.totalAmount.toStringAsFixed(0)}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
