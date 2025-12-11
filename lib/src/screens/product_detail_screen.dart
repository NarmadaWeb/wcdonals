import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'Reguler';
  final List<String> _selectedAddOns = [];
  int _quantity = 1;

  void _toggleAddOn(String name) {
    setState(() {
      if (_selectedAddOns.contains(name)) {
        _selectedAddOns.remove(name);
      } else {
        _selectedAddOns.add(name);
      }
    });
  }

  int get _totalPrice {
    int price = widget.product.price.toInt();
    if (_selectedSize == 'Large') {
      price += 5000;
    }
    for (var addOnName in _selectedAddOns) {
       final addOn = widget.product.allowedAddOns.firstWhere(
        (a) => a.name == addOnName,
        orElse: () => AddOn(name: '', price: 0),
      );
      price += addOn.price;
    }
    return price * _quantity;
  }

  void _addToCart() {
    Provider.of<CartProvider>(context, listen: false).addToCart(
      widget.product,
      quantity: _quantity,
      size: _selectedSize,
      addOns: _selectedAddOns,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 32),
            ),
            const SizedBox(height: 16),
            const Text(
              'Berhasil Ditambahkan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.product.name} telah masuk ke keranjangmu.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close sheet
                      Navigator.pop(context); // Close detail screen
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                    child: const Text('Lanjut Belanja'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/cart');
                    },
                     style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                    child: const Text('Lihat Keranjang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(Icons.share, color: Colors.black),
                          onPressed: () {},
                        )),
                  )
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Rp ${_totalPrice.toStringAsFixed(0)}', // Update dynamic price
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.product.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Ukuran',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSizeOption('Reguler', 0),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSizeOption('Large', 5000),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (widget.product.allowedAddOns.isNotEmpty) ...[
                        Text(
                          'Tambahan',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        ...widget.product.allowedAddOns.map(
                          (addOn) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildAddOnOption(addOn.name, addOn.price),
                          ),
                        ),
                      ],

                      const SizedBox(height: 100), // Space for bottom bar
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (_quantity > 1) setState(() => _quantity--);
                          },
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.add,
                              color: Theme.of(context).primaryColor),
                          onPressed: () {
                            setState(() => _quantity++);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: _addToCart,
                        child: const Text('Tambah ke Keranjang',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size, int extraPrice) {
    final isSelected = _selectedSize == size;
    return GestureDetector(
      onTap: () => setState(() => _selectedSize = size),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            extraPrice > 0 ? '$size (+Rp $extraPrice)' : size,
            style: TextStyle(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddOnOption(String name, int price) {
    final isSelected = _selectedAddOns.contains(name);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                price > 0 ? '+Rp $price' : 'Gratis',
                style: TextStyle(
                  color:
                      price > 0 ? Theme.of(context).primaryColor : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Switch(
            value: isSelected,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (val) => _toggleAddOn(name),
          ),
        ],
      ),
    );
  }
}
