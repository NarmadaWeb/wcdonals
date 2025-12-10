import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'src/services/db_init.dart';
import 'src/providers/auth_provider.dart';
import 'src/providers/cart_provider.dart';
import 'src/utils/theme.dart';
import 'src/screens/welcome_screen.dart';
import 'src/screens/auth_screen.dart';
import 'src/screens/home_screen.dart';
import 'src/screens/product_detail_screen.dart';
import 'src/screens/cart_screen.dart';
import 'src/screens/payment_screen.dart';
import 'src/screens/profile_screen.dart';
import 'src/screens/edit_profile_screen.dart';
import 'src/screens/settings_screen.dart';
import 'src/screens/splash_screen.dart';
import 'src/models/product_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Database Factory (Web or Native)
  initializeDatabaseFactory();

  runApp(const WcDonaldsApp());
}

class WcDonaldsApp extends StatelessWidget {
  const WcDonaldsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'WcDonalds',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: '/splash',
        onGenerateRoute: (settings) {
            switch (settings.name) {
                case '/splash':
                    return MaterialPageRoute(builder: (_) => const SplashScreen());
                case '/welcome':
                    return MaterialPageRoute(builder: (_) => const WelcomeScreen());
                case '/auth':
                    return MaterialPageRoute(builder: (_) => const AuthScreen());
                case '/home':
                    return MaterialPageRoute(builder: (_) => const HomeScreen());
                case '/product':
                    final product = settings.arguments as Product;
                    return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product));
                case '/cart':
                    return MaterialPageRoute(builder: (_) => const CartScreen());
                case '/payment':
                    return MaterialPageRoute(builder: (_) => const PaymentScreen());
                case '/profile':
                    return MaterialPageRoute(builder: (_) => const ProfileScreen());
                case '/edit_profile':
                    return MaterialPageRoute(builder: (_) => const EditProfileScreen());
                case '/settings':
                    return MaterialPageRoute(builder: (_) => const SettingsScreen());
                default:
                    return MaterialPageRoute(builder: (_) => const WelcomeScreen());
            }
        },
      ),
    );
  }
}
