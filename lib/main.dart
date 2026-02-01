import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/providers/auth_provider.dart';
import 'src/providers/cart_provider.dart';
import 'src/providers/theme_provider.dart';
import 'src/providers/order_provider.dart';
import 'src/providers/notification_provider.dart';
import 'src/providers/menu_provider.dart';
import 'src/utils/theme.dart';
import 'src/screens/welcome_screen.dart';
import 'src/screens/auth_screen.dart';
import 'src/screens/product_detail_screen.dart';
import 'src/screens/cart_screen.dart';
import 'src/screens/payment_screen.dart';
import 'src/screens/profile_screen.dart';
import 'src/screens/edit_profile_screen.dart';
import 'src/screens/settings_screen.dart';
import 'src/screens/splash_screen.dart';
import 'src/screens/menu_screen.dart';
import 'src/screens/order_screen.dart';
import 'src/screens/help_screen.dart';
import 'src/screens/notification_screen.dart';
import 'src/screens/main_screen.dart';
import 'src/screens/admin/admin_dashboard.dart';
import 'src/screens/admin/manage_menu_screen.dart';
import 'src/screens/admin/manage_orders_screen.dart';
import 'src/screens/admin/edit_product_screen.dart';
import 'src/models/product_model.dart';
import 'src/services/db_init.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDatabaseFactory();
  // Database initialized lazily via DatabaseHelper

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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'WcDonalds',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            initialRoute: '/splash',
            theme: AppTheme.lightTheme.copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            darkTheme: AppTheme.darkTheme.copyWith(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/splash':
                  return MaterialPageRoute(
                      builder: (_) => const SplashScreen());
                case '/welcome':
                  return MaterialPageRoute(
                      builder: (_) => const WelcomeScreen());
                case '/auth':
                  return MaterialPageRoute(builder: (_) => const AuthScreen());
                case '/home':
                  return MaterialPageRoute(builder: (_) => const MainScreen());
                case '/product':
                  final product = settings.arguments as Product;
                  return MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product));
                case '/cart':
                  return MaterialPageRoute(builder: (_) => const CartScreen());
                case '/menu':
                  return MaterialPageRoute(builder: (_) => const MenuScreen());
                case '/orders':
                  return MaterialPageRoute(builder: (_) => const OrderScreen());
                case '/payment':
                  return MaterialPageRoute(
                      builder: (_) => const PaymentScreen());
                case '/profile':
                  return MaterialPageRoute(
                      builder: (_) => const ProfileScreen());
                case '/edit_profile':
                  return MaterialPageRoute(
                      builder: (_) => const EditProfileScreen());
                case '/settings':
                  return MaterialPageRoute(
                      builder: (_) => const SettingsScreen());
                case '/help':
                  return MaterialPageRoute(builder: (_) => const HelpScreen());
                case '/notification':
                  return MaterialPageRoute(
                      builder: (_) => const NotificationScreen());
                case '/admin_dashboard':
                  return MaterialPageRoute(
                      builder: (_) => const AdminDashboard());
                case '/admin_menu':
                  return MaterialPageRoute(
                      builder: (_) => const ManageMenuScreen());
                case '/admin_orders':
                  return MaterialPageRoute(
                      builder: (_) => const ManageOrdersScreen());
                case '/edit_product':
                  final product = settings.arguments as Product?;
                  return MaterialPageRoute(
                      builder: (_) => EditProductScreen(product: product));
                default:
                  return MaterialPageRoute(
                      builder: (_) => const WelcomeScreen());
              }
            },
          );
        },
      ),
    );
  }
}
