import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/wcdonalds_logo.dart';
import '../utils/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Blobs
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 192,
              height: 192,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.transparent, // Placeholder for blur
                  )
              ),
            ),
          ),
           Positioned(
            bottom: -96,
            left: -96,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: AppTheme.accent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Logo
                  Container(
                    width: 96,
                    height: 96,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const WcDonaldsLogo(color: AppTheme.accent, size: 60),
                  ),
                  const SizedBox(height: 32),
                  // Headline
                  Text(
                    'Selamat Datang di WcDonald',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Subtitle
                  Text(
                    'Pesan favoritmu, lebih cepat dan mudah.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
                    ),
                  ),
                  const Spacer(),
                  // Buttons
                  CustomButton(
                    text: 'Mulai Sekarang',
                    onPressed: () {
                        Navigator.pushNamed(context, '/auth');
                    },
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'Masuk',
                    isPrimary: false,
                    onPressed: () {
                         Navigator.pushNamed(context, '/auth');
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
