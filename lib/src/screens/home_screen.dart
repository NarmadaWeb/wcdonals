import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/product_model.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _categories = [
    'Semua',
    'Burger',
    'Ayam',
    'Kentang',
    'Minuman',
    'Dessert'
  ];
  String _selectedCategory = 'Semua';

  void _onNavTap(int index) {
    if (index == 0) return; // Already here
    // Navigation logic for other tabs
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
        case 1:
            // Scroll to menu or just filter
            break;
        case 2:
            // Go to orders
             // For this demo, maybe we just show a placeholder or navigate to cart if it was cart
             Navigator.pushNamed(context, '/cart');
             setState(() => _currentIndex = 0); // Reset
            break;
        case 3:
             Navigator.pushNamed(context, '/profile');
             setState(() => _currentIndex = 0); // Reset
            break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    List<Product> displayedProducts = mockProducts;
    if (_selectedCategory != 'Semua') {
      displayedProducts = mockProducts.where((p) => p.category == _selectedCategory).toList();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
            children: [
             SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 100), // Space for bottom nav
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Bar
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
                            onBackgroundImageError: (_,__) => {},
                            child: user?.avatarUrl == null ? const Icon(Icons.person) : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat datang, ${user?.name ?? 'Tamu'}!',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 14, color: Theme.of(context).primaryColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Kirim ke: ${user?.address?.split(',').first ?? 'Lokasi Kamu'}',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),

                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari makanan favoritmu...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Carousel (Simulated with SingleChildScrollView)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          _buildPromoBanner(
                            context,
                            'Promo Spesial Hari Ini!',
                            'Diskon 50% untuk menu pilihan',
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuA1qKbRYQUULXHkP3yQvZDltDaBy-y68_E__4FHf_Kwqxb7G15B0jsbwylqUtpZl4AyrSTwznjOF0tCAgYn-OhuHBFxRLRmAm4q0I_BBPULe9WqQ1FIPglk6q-JMosuO1rwJ8hq5-8TQRxWrGyRe83HxCUkVNyCLNl9VhjPSbMnI4vHFOiTC9kOIosTbdrWywLAIB-lN3toAaEOr0L-WjqUEJ41OcrF0H3BOp3P8WQkt_aDcobaySznNTnrHquW4A50Eu7qQ3iYig',
                          ),
                          const SizedBox(width: 16),
                          _buildPromoBanner(
                            context,
                            'Paket Hemat Keluarga',
                            'Pilihan tepat makan bersama',
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBUGMm7AOpCc_ztbQImX_ITIs7qVKjCqJPq5QRFbU5JgPaONqMbCclzltNAr-YyNB07Jiq_GMmumTNcfzjnM6r5_97Esj_DjR1D3RsreImK9ZKt8CnVQ7U-HcBfy3JXc7JITxjcD2o95UO7UHXIBWGmngqji6KTI2eMdEuNGxxNv52hp3n6tJbqIiqNaldw3olDej4pEF65Oh8JA6pHc6WOqP035ncDwzRG0xXbA6GxgT_uCDpfKRDnbQP49iakQfg3qDAh3L3kRg',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Categories
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: _categories.map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: GestureDetector(
                                    onTap: () => setState(() => _selectedCategory = cat),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Text(
                                            cat,
                                            style: TextStyle(
                                                color: isSelected ? Colors.white : Theme.of(context).colorScheme.onBackground,
                                                fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                    ),
                                ),
                            );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Recommended Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rekomendasi Populer',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Lihat Semua',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Product Grid
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                        ),
                        itemCount: displayedProducts.length,
                        itemBuilder: (context, index) {
                            final product = displayedProducts[index];
                            return GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        '/product',
                                        arguments: product
                                    );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.black.withOpacity(0.05),
                                                blurRadius: 10,
                                            )
                                        ]
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Expanded(
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12),
                                                        image: DecorationImage(
                                                            image: NetworkImage(product.imageUrl),
                                                            fit: BoxFit.cover,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                                product.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                    Text(
                                                        'Rp ${product.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Container(
                                                        padding: const EdgeInsets.all(4),
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(context).colorScheme.secondary,
                                                            shape: BoxShape.circle,
                                                        ),
                                                        child: const Icon(Icons.add, size: 20, color: Colors.black),
                                                    )
                                                ],
                                            )
                                        ],
                                    ),
                                ),
                            );
                        },
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavBar(
                      currentIndex: _currentIndex,
                      onTap: _onNavTap,
                  ),
              ),
            ]
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context, String title, String subtitle, String imageUrl) {
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
        )
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            )
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
        ),
      ),
    );
  }
}
