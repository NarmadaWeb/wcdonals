import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Save path
      // ignore: use_build_context_synchronously
      Provider.of<AuthProvider>(context, listen: false)
          .updateAvatar(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    ImageProvider? avatarImage;
    if (user?.avatarUrl != null) {
      if (user!.avatarUrl!.startsWith('http')) {
        avatarImage = NetworkImage(user.avatarUrl!);
      } else {
        avatarImage = FileImage(File(user.avatarUrl!));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Akun',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: avatarImage,
                    onBackgroundImageError: (_, __) {},
                    child: avatarImage == null
                        ? const Icon(Icons.person, size: 64)
                        : null,
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickImage(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child:
                        const Icon(Icons.edit, size: 16, color: Colors.black),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'Tamu',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),

            const SizedBox(height: 32),

            // Menu Items
            _buildMenuItem(context, Icons.person, 'Edit Profil', () {
              Navigator.pushNamed(context, '/edit_profile');
            }),
            const SizedBox(height: 12),
            _buildMenuItem(context, Icons.settings, 'Pengaturan Aplikasi', () {
              Navigator.pushNamed(context, '/settings');
            }),
            const SizedBox(height: 12),
            _buildMenuItem(context, Icons.help_center, 'Bantuan', () {
              Navigator.pushNamed(context, '/help');
            }),

            const SizedBox(height: 32),

            TextButton.icon(
              onPressed: () {
                auth.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/welcome', (route) => false);
              },
              icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              label: Text('Keluar',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .scaffoldBackgroundColor, // subtle contrast
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon,
                  size: 20, color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
