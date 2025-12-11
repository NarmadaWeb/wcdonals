class AddOn {
  final String name;
  final int price;

  AddOn({required this.name, required this.price});
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // 'Burger', 'Ayam', 'Kentang', 'Minuman', 'Dessert'
  final List<AddOn> allowedAddOns;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.allowedAddOns = const [],
  });
}

// Mock Data Lengkap (20 Items)
final List<Product> mockProducts = [
  // --- BURGER (6 Items) ---
  Product(
    id: '1',
    name: 'Beef Burger',
    description: 'Daging sapi pilihan dengan sayuran segar.',
    price: 35000,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAkgXuFSM2KseLEw8BtIBjAqHNi_Bs90xS74lexgI1rjtfvm4j4P4NFAMRQDaaoTsMhiSK70qF4Ne5jg_6yJsidaToDLYzKDfZBN0IiAyD4TbM26wH1b6d_bQ3xNoLHnGPV86q122F2OH0yN7gbi03BJJJzLt2VJycL2JdQxiaVgUxVv8Ii8J7taiWYPXFEVVWaYfI6JiYpWGchumnvJEjpYlWO1iUhODOC0gwlASyfgouoIQPbr9C9ol3dJoafVYdUh554sh0tlw',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),
  Product(
    id: '2',
    name: 'Big Wac Burger',
    description:
        'Dua lapis daging sapi gurih dengan saus spesial, selada, keju, acar, bawang, diapit roti wijen.',
    price: 45000,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuA5P7IeqDxvH3CJ_bG2JAp_gJP1DnsJVpFZVCJGEm5HPmaNrceOBWYA2QM-nGVlJZN8UGPRQDpWXCiTOkJcbDGC7ZGl6gXGqAMfFCYVNbE0Q4G3S3TsVH7VhQkdyaLVjZyiT-797xnPRPtm2MdLnwrps6QutSOnX82KY9kinWuXm1XfovNd7hrdaOyaePOFOqvP4QguhH5CXPMeaOfacl3bEDGKg7LDBWroVYExXbu7nalMEwlJ_25Np8YsQHwScKUdN_B41yjctA',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),
  Product(
    id: '3',
    name: 'WcSpicy Burger',
    description: 'Burger dengan saus pedas spesial untuk pecinta pedas.',
    price: 35000,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBfzI4nodrd0KnNqfJ6uXx04VTZBcHls2UKOgHidTRZpKSdjmvj_vQSK2jhiGEE2TeXf8ouOHzLQh6QXY_w3B2c661drhFen5lk8iRaAAXeCDN3Q2xJomMJFxR6ciw1PyVTalCZZXjY_N69ZAg8loZ-C-sPBmM470njaqHR5HWZGFF9rWCHwbiqQ95kwPljicQ7z6Ff9E2USsvjC0DwK-ojrCOOlHukLpziZXluu3Az4aIILYv-1XiV7UbTg2Jp1tASaxAZBfdkdA',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),
  Product(
    id: '4',
    name: 'Double Cheeseburger',
    description: 'Burger dengan dua lapis daging sapi dan keju meleleh.',
    price: 42000,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuB0lw0kcIE3Esz9Rgyk5XcRf8shSJNsfsPokOwj75OYmVM62238amhChCmHxkOgFQJskkjCSpFQ4hbKP8MpfJxN7jXHbTYsd_sAlWh26PWfTUO5AmxnCaP7j9Kufm7dCTuUmYngnF7zs2iG8h_TiQ-YIBW0_mAv-k3M__gSfkYAm2-Uy2F9YfnwRiUk9SemtTbDsonrdK3UzC0Qu7EwShsCD3aNnKebyGwC3c5uU9h1UGn3K2x-SJbxcyESEMbYHBEdGKiMbvGL2Q',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),
  Product(
    id: '5',
    name: 'Fish Fillet Burger',
    description: 'Filet ikan renyah dengan saus tartar yang creamy.',
    price: 38000,
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBUj2VJfv9SDuNUhnQWcFdnTX37dR03ohMFAfbe5FIYrT9PZumpNwBPnGsL10rkG-PGvZ7kumWlERbOHwlH8pR9DCAO6kCfkm4gvwoteJ921cBk_-xwAA-TqsbP-t4ctoq_nWE4MF1pWy1GDYqw3oS6nAPtNQvXaWkVP-e_SyzKLm5lT_4pAH9HgxeRiqJeN6QiReeOe02KSpr66BqxzghAwgw8edu961NL0X09UDpVeJVvmM4hTC5okjX-IDvcMW8o-WnwZ1DwVA',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),
  Product(
    id: '6',
    name: 'Chicken Burger Deluxe',
    description: 'Daging ayam crispy dengan mayones dan selada segar.',
    price: 33000,
    imageUrl:
        'https://imgs.search.brave.com/Pbhfn8pDtbAamnYUj4GIxlXOYUKaE9YrbdmpNetZqNE/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvNDcx/MTY0NDk4L3Bob3Rv/L2NoaWNrZW4taGFt/YnVyZ2VyLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz14OEVW/N2sxSzdsajVuSDVL/WkJZaTVOUHJvUkht/eFRKY2xDX09zeGdU/VGhFPQ',
    category: 'Burger',
    allowedAddOns: [
      AddOn(name: 'Ekstra Keju', price: 5000),
      AddOn(name: 'Ekstra Patty', price: 15000),
      AddOn(name: 'Acar', price: 0),
    ],
  ),

  // --- AYAM (4 Items) ---
  Product(
    id: '7',
    name: 'Ayam Goreng Krispi',
    description: 'Ayam goreng original dengan bumbu rahasia WcDonald.',
    price: 25000,
    imageUrl:
        'https://imgs.search.brave.com/htQWOuh5wXipYRhqXV0YubxyYCF3IXoxS2GxyYoZnCU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzE2LzY1Lzc3LzI5/LzM2MF9GXzE2NjU3/NzI5NjZfYzRFbGl3/SU01SGh5ME9WZXNM/bDBSaHpQZnVJZUti/cW4uanBn',
    category: 'Ayam',
    allowedAddOns: [
      AddOn(name: 'Saus BBQ', price: 3000),
      AddOn(name: 'Saus Keju', price: 4000),
      AddOn(name: 'Nasi Putih', price: 6000),
    ],
  ),
  Product(
    id: '8',
    name: 'Ayam Spicy',
    description: 'Ayam goreng dengan taburan bumbu pedas yang nendang.',
    price: 26000,
    imageUrl:
        'https://imgs.search.brave.com/JfsmCrH5qRueY5vKiK72wBw648psVTI5S9AHlvnuAw4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jbmMt/bWFnYXppbmUub3Jh/bWlsYW5kLmNvbS9w/YXJlbnRpbmcvaW1h/Z2VzL1NjcmVlbnNo/b3RfNDFfMGF5UUpq/dC53aWR0aC04MDAu/Zm9ybWF0LXdlYnAu/d2VicA',
    category: 'Ayam',
    allowedAddOns: [
      AddOn(name: 'Saus BBQ', price: 3000),
      AddOn(name: 'Saus Keju', price: 4000),
      AddOn(name: 'Nasi Putih', price: 6000),
    ],
  ),
  Product(
    id: '9',
    name: 'WcNuggets (6 pcs)',
    description: 'Nugget ayam olahan yang empuk dan renyah.',
    price: 22000,
    imageUrl:
        'https://imgs.search.brave.com/JjDEtlVE5B4tKVx1YTYzSR7H3VcPCJqbHBbp2yxFipc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdDQu/ZGVwb3NpdHBob3Rv/cy5jb20vMzcwNzY3/ODAvMzgzMzYvaS80/NTAvZGVwb3NpdHBo/b3Rvc18zODMzNjQ0/NjYtc3RvY2stcGhv/dG8tY2hpY2tlbi1u/dWdnZXRzLXdoaXRl/LWJhY2tncm91bmQu/anBn',
    category: 'Ayam',
  ),
  Product(
    id: '10',
    name: 'Chicken Strips',
    description: 'Potongan dada ayam tanpa tulang yang digoreng tepung.',
    price: 28000,
    imageUrl:
        'https://imgs.search.brave.com/78DcQ651QxoGpi3xBulTfvcmCRHkCr0TR03pYW4GBvI/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMuYXhpb3MuY29t/L01lTVlfcDdqVEIt/cWRaX0VXVk45VTRH/RGlxZz0vMHgwOjU1/MDB4MzA5NC8xOTIw/eDEwODAvMjAyNS8w/NC8yNC8xNzQ1NDYz/MzE3NjAzLmpwZz93/PTM4NDA',
    category: 'Ayam',
  ),

  // --- KENTANG (3 Items) ---
  Product(
    id: '11',
    name: 'Kentang Goreng',
    description: 'Potongan kentang emas yang renyah dan gurih.',
    price: 18000,
    imageUrl:
        'https://imgs.search.brave.com/IS4LAMVEKDA7FrIDAcZ2ueaHAF3K1OUfNgMreHonCgQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9hc3Nl/dC5rb21wYXMuY29t/L2Nyb3BzL3VpZ2xR/ZU5TOHliSV9rTVRf/WE1yNGk1UXNwRT0v/MHgyOjg4MHg1ODgv/MTIwMHg4MDAvZGF0/YS9waG90by8yMDIy/LzA5LzE0LzYzMjE1/OWNkODExZjIuanBn',
    category: 'Kentang',
    allowedAddOns: [
      AddOn(name: 'Saus Keju', price: 4000),
      AddOn(name: 'Bumbu BBQ', price: 2000),
    ],
  ),
  Product(
    id: '12',
    name: 'Potato Wedges',
    description: 'Potongan kentang berbumbu yang lebih tebal dan padat.',
    price: 22000,
    imageUrl:
        'https://imgs.search.brave.com/f1HvsnBoHjrghRLLpRaCdDY2JyTNd-WcbGxQ8ih5Rbc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/cHJlbWl1bS1waG90/by9wbGF0ZS13aXRo/LXRhc3R5LXBvdGF0/by13ZWRnZXMtdG9t/YXRvLXNhdWNlXzM5/Mjg5NS00Mzk0Ni5q/cGc_c2VtdD1haXNf/aW5jb21pbmcmdz03/NDAmcT04MA',
    category: 'Kentang',
  ),
  Product(
    id: '13',
    name: 'Hash Brown',
    description: 'Olahan kentang cincang yang digoreng pipih kecokelatan.',
    price: 15000,
    imageUrl:
        'https://imgs.search.brave.com/jikU0MFx3fXzDhKXrAc6R489OGmarNylPqmMvHPev1w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/dGFzdHliaXRzLmRl/L3dwLWNvbnRlbnQv/dXBsb2Fkcy8yMDIx/LzA4L2hhc2gtYnJv/d25zLXJlemVwdF9y/LmpwZw',
    category: 'Kentang',
  ),

  // --- MINUMAN (4 Items) ---
  Product(
    id: '14',
    name: 'Cola Dingin',
    description: 'Minuman bersoda rasa cola yang menyegarkan.',
    price: 12000,
    imageUrl:
        'https://imgs.search.brave.com/lNLpc0Hyd6LbfVuK-2oGbmSZlSOUZp24I0RVt-7D-_Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90YXN0/eXNuYWNrLmlkL2Nk/bi9zaG9wL2ZpbGVz/LzFfZGMyMmQwYjAt/NDI5Ni00NGE5LWI5/OTAtZDMxZGIyMTdl/NDQwXzEwMDB4MTAw/MC5wbmc_dj0xNzI4/OTAwODQ3',
    category: 'Minuman',
    allowedAddOns: [
      AddOn(name: 'Less Ice', price: 0),
      AddOn(name: 'Extra Ice', price: 0),
      AddOn(name: 'Upsize', price: 5000),
    ],
  ),
  Product(
    id: '15',
    name: 'Lemon Tea',
    description: 'Teh rasa lemon dingin yang manis dan asam segar.',
    price: 10000,
    imageUrl:
        'https://imgs.search.brave.com/etuJ4z5BgngeUstAWJ0jI08dvECHj_p4TprIHN8fNP0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wMDQv/OTM1LzY1OC9zbWFs/bC9nbGFzcy1vZi1p/Y2UtbGVtb24tdGVh/LXBob3RvLmpwZw',
    category: 'Minuman',
    allowedAddOns: [
      AddOn(name: 'Less Ice', price: 0),
      AddOn(name: 'Extra Ice', price: 0),
      AddOn(name: 'Upsize', price: 5000),
    ],
  ),
  Product(
    id: '16',
    name: 'Hot Coffee',
    description: 'Kopi hitam panas dari biji kopi pilihan.',
    price: 15000,
    imageUrl:
        'https://imgs.search.brave.com/my6r6ZbTDfQp9S9z2OMZksGUUogJA7RTrWie7puXsus/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzLzdlLzAx/Lzc0LzdlMDE3NDE2/YmI4Y2VhZDI4Yzc3/ZDViYjEyZmNkZmNh/LmpwZw',
    category: 'Minuman',
    allowedAddOns: [
      AddOn(name: 'Extra Sugar', price: 0),
      AddOn(name: 'Less Sugar', price: 0),
    ],
  ),

  // --- DESSERT (3 Items) ---
  Product(
    id: '17',
    name: 'WcFlurry Oreo',
    description: 'Es krim vanilla lembut dicampur remahan biskuit Oreo.',
    price: 15000,
    imageUrl:
        'https://imgs.search.brave.com/XQEQKLMFgZcX7g2LO3iMZXeaAZr1VfWHl5jPf3oQR_8/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzE1LzQwLzU5Lzkz/LzM2MF9GXzE1NDA1/OTkzNzNfZTFiQ09Q/bkd3aUxSb1Fjc0lz/eDd0Mno5MnhwNXY2/Uk4uanBn',
    category: 'Dessert',
  ),
  Product(
    id: '18',
    name: 'Ice Cream Cone',
    description: 'Es krim vanilla klasik dengan cone renyah.',
    price: 8000,
    imageUrl:
        'https://imgs.search.brave.com/0zwKgZviS3XAjUuRNxjSSDMpEmSRha2vAopdVdi5dC0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2FmL2Mz/LzZiL2FmYzM2YjNh/ZTk2NzA3Njk0ZTY5/YWEwNTUyMDkzOTE3/LmpwZw',
    category: 'Dessert',
  ),
  Product(
    id: '19',
    name: 'Apple Pie',
    description: 'Pie hangat dengan isian potongan apel dan kayu manis.',
    price: 12000,
    imageUrl:
        'https://imgs.search.brave.com/bPM9RYxAkE77OKDaBXT6kopVylyjyzHUzsYz20D8Src/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/ZWluZmFjaGtvY2hl/bi5kZS9zaXRlcy9l/aW5mYWNoa29jaGVu/LmRlL2ZpbGVzL3N0/eWxlcy9mdWxsX3dp/ZHRoX3RhYmxldF80/XzMvcHVibGljLzIw/MjUtMDMvMjAyNV9h/cHBsZS1waWVfYXVm/bWFjaGVyLmpwZz9o/PWQ3MDljMWZiJml0/b2s9NXh6VFdIN0s',
    category: 'Dessert',
  ),
];
