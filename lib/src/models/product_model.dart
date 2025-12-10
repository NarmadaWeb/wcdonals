class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // 'Burger', 'Ayam', 'Kentang', 'Minuman', 'Dessert'

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}

// Mock Data
final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Beef Burger',
    description: 'Daging sapi pilihan dengan sayuran segar.',
    price: 35000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAKSzkghgs3wNPCPuOfuUPcnldygZDEkWZHRvSKl_6L7d2imvtCq3O3cqcmSl9IIM78FyAHkUPYDij_2JpucUhuMySv3YNkAwgdkd4S6U1XNapRuDp7TCjSETBx4JBmJT4rl3HeH6viTx2Y0WduFKOpT0Unb-BPuE4MKPpvuWpjj2OEgcxJxrAg7CaVWF-Uez37SuzplzF6ifbaCUN7oqVHswDSIABPp1vTvlUP0bwNoQRmLGBH74M7Hj3-btLM1UDnUrf-qtnNSg',
    category: 'Burger',
  ),
  Product(
    id: '2',
    name: 'Ayam Goreng Krispi',
    description: 'Ayam goreng dengan bumbu rahasia WcDonald.',
    price: 25000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAkgXuFSM2KseLEw8BtIBjAqHNi_Bs90xS74lexgI1rjtfvm4j4P4NFAMRQDaaoTsMhiSK70qF4Ne5jg_6yJsidaToDLYzKDfZBN0IiAyD4TbM26wH1b6d_bQ3xNoLHnGPV86q122F2OH0yN7gbi03BJJJzLt2VJycL2JdQxiaVgUxVv8Ii8J7taiWYPXFEVVWaYfI6JiYpWGchumnvJEjpYlWO1iUhODOC0gwlASyfgouoIQPbr9C9ol3dJoafVYdUh554sh0tlw',
    category: 'Ayam',
  ),
  Product(
    id: '3',
    name: 'Kentang Goreng',
    description: 'Potongan kentang emas yang renyah.',
    price: 18000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuA5P7IeqDxvH3CJ_bG2JAp_gJP1DnsJVpFZVCJGEm5HPmaNrceOBWYA2QM-nGVlJZN8UGPRQDpWXCiTOkJcbDGC7ZGl6gXGqAMfFCYVNbE0Q4G3S3TsVH7VhQkdyaLVjZyiT-797xnPRPtm2MdLnwrps6QutSOnX82KY9kinWuXm1XfovNd7hrdaOyaePOFOqvP4QguhH5CXPMeaOfacl3bEDGKg7LDBWroVYExXbu7nalMEwlJ_25Np8YsQHwScKUdN_B41yjctA',
    category: 'Kentang',
  ),
  Product(
    id: '4',
    name: 'Cola Dingin',
    description: 'Minuman bersoda yang menyegarkan.',
    price: 12000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfzI4nodrd0KnNqfJ6uXx04VTZBcHls2UKOgHidTRZpKSdjmvj_vQSK2jhiGEE2TeXf8ouOHzLQh6QXY_w3B2c661drhFen5lk8iRaAAXeCDN3Q2xJomMJFxR6ciw1PyVTalCZZXjY_N69ZAg8loZ-C-sPBmM470njaqHR5HWZGFF9rWCHwbiqQ95kwPljicQ7z6Ff9E2USsvjC0DwK-ojrCOOlHukLpziZXluu3Az4aIILYv-1XiV7UbTg2Jp1tASaxAZBfdkdA',
    category: 'Minuman',
  ),
   Product(
    id: '5',
    name: 'Big Wac Burger',
    description: 'Dua lapis daging sapi gurih dengan saus spesial, selada, keju, acar, bawang, diapit roti wijen.',
    price: 45000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB0lw0kcIE3Esz9Rgyk5XcRf8shSJNsfsPokOwj75OYmVM62238amhChCmHxkOgFQJskkjCSpFQ4hbKP8MpfJxN7jXHbTYsd_sAlWh26PWfTUO5AmxnCaP7j9Kufm7dCTuUmYngnF7zs2iG8h_TiQ-YIBW0_mAv-k3M__gSfkYAm2-Uy2F9YfnwRiUk9SemtTbDsonrdK3UzC0Qu7EwShsCD3aNnKebyGwC3c5uU9h1UGn3K2x-SJbxcyESEMbYHBEdGKiMbvGL2Q',
    category: 'Burger',
  ),
  Product(
    id: '6',
    name: 'WcSpicy Burger',
    description: 'Burger dengan saus pedas spesial.',
    price: 35000,
    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBUj2VJfv9SDuNUhnQWcFdnTX37dR03ohMFAfbe5FIYrT9PZumpNwBPnGsL10rkG-PGvZ7kumWlERbOHwlH8pR9DCAO6kCfkm4gvwoteJ921cBk_-xwAA-TqsbP-t4ctoq_nWE4MF1pWy1GDYqw3oS6nAPtNQvXaWkVP-e_SyzKLm5lT_4pAH9HgxeRiqJeN6QiReeOe02KSpr66BqxzghAwgw8edu961NL0X09UDpVeJVvmM4hTC5okjX-IDvcMW8o-WnwZ1DwVA',
    category: 'Burger',
  ),
];
