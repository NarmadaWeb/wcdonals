import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/order_provider.dart';
import '../../models/order_model.dart';

class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Pesanan')),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
           if (provider.isLoading && provider.orders.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.orders.isEmpty) {
            return const Center(child: Text('Belum ada pesanan.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.orders.length,
            itemBuilder: (context, index) {
              final order = provider.orders[index];
              final idDisplay = order.id.length > 8 ? '${order.id.substring(0, 8)}...' : order.id;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text('Order #$idDisplay', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${DateFormat('dd MMM yyyy, HH:mm').format(order.date)} - Rp ${order.totalAmount.toStringAsFixed(0)}'),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      order.status.name.toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)
                    ),
                  ),
                  children: [
                    ...order.items.map((item) => ListTile(
                      dense: true,
                      title: Text('${item.product.name} (x${item.quantity})'),
                      subtitle: item.addOns.isNotEmpty ? Text('Add-ons: ${item.addOns.join(', ')}') : null,
                      trailing: Text('Rp ${item.totalPrice.toStringAsFixed(0)}'),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           const Text('Total: ', style: TextStyle(fontWeight: FontWeight.bold)),
                           Text('Rp ${order.totalAmount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch(status) {
      case OrderStatus.pending: return Colors.orange;
      case OrderStatus.processing: return Colors.blue;
      case OrderStatus.completed: return Colors.green;
      case OrderStatus.cancelled: return Colors.red;
    }
  }
}
