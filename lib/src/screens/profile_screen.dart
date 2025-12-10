import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Akun', style: TextStyle(fontWeight: FontWeight.bold)),
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
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
                  onBackgroundImageError: (_,__) {},
                  child: user?.avatarUrl == null ? const Icon(Icons.person, size: 64) : null,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.edit, size: 16, color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user?.name ?? 'Tamu',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
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
            _buildMenuItem(context, Icons.help_center, 'Bantuan', () {}),

            const SizedBox(height: 32),

            TextButton.icon(
              onPressed: () {
                auth.logout();
                Navigator.pushNamedAndRemoveUntil(context, '/welcome', (route) => false);
              },
              icon: Icon(Icons.logout, color: Theme.of(context).primaryColor),
              label: Text('Keluar', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3,
        onTap: (index) {
             if (index == 3) return;
             if (index == 0) {
                 Navigator.pushReplacementNamed(context, '/home');
             }
             // Handle others
        },
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
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
                color: Theme.of(context).scaffoldBackgroundColor, // subtle contrast
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
