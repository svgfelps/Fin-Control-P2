import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final provider = context.read<AuthProvider>();
    final error = await provider.login(_emailController.text.trim(), _passwordController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ?? 'Login realizado com sucesso!')));
    if (error == null) Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance_wallet, size: 70),
                const SizedBox(height: 12),
                const Text('FinControl', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail'), validator: Validators.validateEmail),
                const SizedBox(height: 16),
                TextFormField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Senha'), obscureText: true, validator: Validators.validatePassword),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: loading ? null : _login, child: Text(loading ? 'Entrando...' : 'Entrar')),
                TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword), child: const Text('Esqueceu a senha?')),
                TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.register), child: const Text('Criar conta')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
