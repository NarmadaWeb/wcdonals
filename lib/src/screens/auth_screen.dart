import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/wcdonalds_logo.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController(); // Only for register

  void _submit() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mohon isi semua field')),
        );
        return;
    }

    bool success;
    if (_isLogin) {
      success = await auth.login(email, password);
    } else {
        if (name.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nama tidak boleh kosong')),
            );
            return;
        }
      success = await auth.register(name, email, password);
    }

    if (success && mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isLogin ? 'Login Gagal' : 'Registrasi Gagal')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Logo Area
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const WcDonaldsLogo(color: Colors.yellow, size: 50),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang Kembali!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              // Toggle
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isLogin ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: _isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    )
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: _isLogin ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isLogin = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !_isLogin ? Theme.of(context).primaryColor : Colors.transparent,
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: !_isLogin
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                    )
                                  ]
                                : [],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Daftar',
                            style: TextStyle(
                              color: !_isLogin ? Colors.white : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Fields
              if (!_isLogin) ...[
                 CustomTextField(
                    label: 'Nama Lengkap',
                    placeholder: 'Masukkan nama Anda',
                    controller: _nameController,
                ),
                const SizedBox(height: 16),
              ],

              CustomTextField(
                label: 'Email',
                placeholder: 'Masukkan email Anda',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                placeholder: 'Masukkan password Anda',
                isPassword: true,
                controller: _passwordController,
              ),

              if (_isLogin) ...[
                const SizedBox(height: 12),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                            'Lupa Password?',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                        )
                    )
                ),
              ] else ...[
                   const SizedBox(height: 24),
              ],

              const SizedBox(height: 12),
              Consumer<AuthProvider>(
                  builder: (context, auth, _) {
                      return auth.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            text: _isLogin ? 'Login' : 'Daftar',
                            onPressed: _submit,
                          );
                  }
              ),

              const SizedBox(height: 32),
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Atau masuk dengan', style: TextStyle(color: Colors.grey.shade500)),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),
              const SizedBox(height: 24),
              // Social Mock
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   _SocialButton(icon: Icons.g_mobiledata, color: Colors.red), // Placeholder for Google
                   const SizedBox(width: 16),
                   _SocialButton(icon: Icons.facebook, color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
    final IconData icon;
    final Color color;
    const _SocialButton({required this.icon, required this.color});

    @override
    Widget build(BuildContext context) {
        return Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
        );
    }
}
