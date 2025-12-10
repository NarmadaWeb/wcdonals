import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantuan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpItem(context, 'Cara Memesan', 'Pilih menu, masukkan keranjang, dan bayar.'),
          _buildHelpItem(context, 'Metode Pembayaran', 'Kami menerima transfer bank dan e-wallet.'),
          _buildHelpItem(context, 'Pengiriman', 'Pengiriman dilakukan oleh kurir WcDonalds.'),
          _buildHelpItem(context, 'Hubungi Kami', 'Email: support@wcdonalds.com\nTelp: 021-1234567'),
        ],
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String title, String content) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(content),
        ),
      ],
    );
  }
}
