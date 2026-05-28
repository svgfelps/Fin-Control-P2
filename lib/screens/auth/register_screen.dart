import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final error = await context.read<AuthProvider>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      city: _cityController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ?? 'Cadastro realizado com sucesso!')));
    if (error == null) Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nome'), validator: (v) => Validators.validateRequired(v, 'Nome')),
            const SizedBox(height: 16),
            TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail'), validator: Validators.validateEmail),
            const SizedBox(height: 16),
            TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Telefone'), validator: (v) => Validators.validateRequired(v, 'Telefone')),
            const SizedBox(height: 16),
            TextFormField(controller: _cityController, decoration: const InputDecoration(labelText: 'Cidade'), validator: (v) => Validators.validateRequired(v, 'Cidade')),
            const SizedBox(height: 16),
            TextFormField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Senha forte'), obscureText: true, validator: Validators.validatePassword),
            const SizedBox(height: 16),
            TextFormField(controller: _confirmPasswordController, decoration: const InputDecoration(labelText: 'Confirmar senha'), obscureText: true, validator: (v) => Validators.validateConfirmPassword(v, _passwordController.text.trim())),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: loading ? null : _register, child: Text(loading ? 'Cadastrando...' : 'Cadastrar')),
          ]),
        ),
      ),
    );
  }
}
