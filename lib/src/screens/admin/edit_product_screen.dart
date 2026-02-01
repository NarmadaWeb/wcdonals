import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product_model.dart';
import '../../providers/menu_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class EditProductScreen extends StatefulWidget {
  final Product? product; // If null, it's adding mode

  const EditProductScreen({super.key, this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  String _category = 'Burger';

  final List<String> _categories = ['Burger', 'Ayam', 'Kentang', 'Minuman', 'Dessert'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descController = TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toStringAsFixed(0) ?? '');
    _imageController = TextEditingController(text: widget.product?.imageUrl ?? '');
    if (widget.product != null) {
      if (_categories.contains(widget.product!.category)) {
        _category = widget.product!.category;
      } else {
        _categories.add(widget.product!.category);
        _category = widget.product!.category;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _save() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama dan Harga wajib diisi')));
        return;
    }

    final double? price = double.tryParse(_priceController.text);
    if (price == null) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harga tidak valid')));
       return;
    }

    final provider = Provider.of<MenuProvider>(context, listen: false);

    final newProduct = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      description: _descController.text,
      price: price,
      imageUrl: _imageController.text.isEmpty
          ? 'https://via.placeholder.com/150'
          : _imageController.text,
      category: _category,
      allowedAddOns: widget.product?.allowedAddOns ?? [],
    );

    try {
      if (widget.product != null) {
        await provider.updateProduct(newProduct);
      } else {
        await provider.addProduct(newProduct);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Tambah Menu' : 'Edit Menu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(label: 'Nama Produk', placeholder: 'Ex: Big Mac', controller: _nameController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Deskripsi', placeholder: 'Deskripsi singkat...', controller: _descController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Harga', placeholder: 'Ex: 50000', controller: _priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            CustomTextField(label: 'URL Gambar', placeholder: 'https://...', controller: _imageController),
            const SizedBox(height: 16),

            const Text('Kategori', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isExpanded: true,
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) => setState(() => _category = val!),
                ),
              ),
            ),
            const SizedBox(height: 32),

            Consumer<MenuProvider>(
              builder: (context, provider, _) {
                return provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(text: 'Simpan', onPressed: _save);
              }
            )
          ],
        ),
      ),
    );
  }
}
