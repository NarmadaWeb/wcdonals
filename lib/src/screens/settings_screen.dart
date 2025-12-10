import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(context, 'General'),
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                    children: [
                        _settingsItem(
                            context,
                            icon: Icons.notifications,
                            title: 'Notifikasi',
                            subtitle: 'Atur preferensi notifikasi Anda',
                            trailing: Switch(value: true, activeColor: Theme.of(context).primaryColor, onChanged: (val){})
                        ),
                        const Divider(height: 1),
                         _settingsItem(
                            context,
                            icon: Icons.language,
                            title: 'Bahasa',
                            subtitle: 'Pilih bahasa aplikasi',
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    Text('Indonesia', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.chevron_right, color: Colors.grey),
                                ],
                            )
                        ),
                    ],
                ),
            ),

            const SizedBox(height: 24),
            _sectionHeader(context, 'Informasi'),
             Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                    children: [
                        _settingsItem(
                            context,
                            icon: Icons.shield,
                            title: 'Privasi',
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey)
                        ),
                         const Divider(height: 1),
                         _settingsItem(
                            context,
                            icon: Icons.info,
                            title: 'Tentang Kami',
                            trailing: const Icon(Icons.chevron_right, color: Colors.grey)
                        ),
                    ],
                ),
             ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
      return Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(title.toUpperCase(), style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2)),
      );
  }

  Widget _settingsItem(BuildContext context, {required IconData icon, required String title, String? subtitle, Widget? trailing}) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
              children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle
                      ),
                      child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              if (subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                              ]
                          ],
                      ),
                  ),
                  if (trailing != null) trailing
              ],
          ),
      );
  }
}
