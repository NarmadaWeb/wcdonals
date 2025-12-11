import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    _nameController = TextEditingController(text: user?.name ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
    _addressController = TextEditingController(text: user?.address ?? '');
  }

  void _save() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = auth.user;
    if (currentUser != null) {
      final updatedUser = currentUser.copyWith(
        name: _nameController.text,
        phone: _phoneController.text,
        address: _addressController.text,
      );
      await auth.updateProfile(updatedUser);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil berhasil diperbarui')));
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuBzyfQVVKwbO5o7_ypesxxwfOs3hxhewjJCwsKs-ol3bE7AGm1igakeCBFScMbtTUFNesJc1RBsn8YcHjmvhk6l0kYgdZeO_8eUVszjsJQ9zBuGYiQBOkbRR7B_UiFYfv8wd88NnK6c8vTQdQoBkqYLJZdGIaFuy14Uo21uO-RtTj4ImbZPd6EG5gu6RKn5wyNqJ4aiaH91dsq8FHYszUQ80nONXgK4wZl_O8BtHHD_SglH7AF5Dz1yMUFDCT6IdA0QPesJpIY4tg'), // Use user avatar or placeholder
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              radius: 20,
                              child: const Icon(Icons.edit,
                                  size: 20, color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                      label: 'Nama Lengkap',
                      placeholder: 'Masukkan nama',
                      controller: _nameController),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Nomor Telepon',
                    placeholder: '08xx-xxxx-xxxx',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                      label: 'Alamat Pengiriman Utama',
                      placeholder: 'Jl. ...',
                      controller: _addressController),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      children: [
                        const Icon(Icons.lock, color: Colors.grey),
                        const SizedBox(width: 12),
                        const Expanded(
                            child: Text('Ubah Kata Sandi',
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Icon(Icons.chevron_right, color: Colors.grey.shade400),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Simpan Perubahan',
              onPressed: _save,
            ),
          )
        ],
      ),
    );
  }
}
