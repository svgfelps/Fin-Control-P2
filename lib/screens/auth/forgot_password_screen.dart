import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/validators.dart';
import '../../providers/auth_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    final error = await context.read<AuthProvider>().forgotPassword(_emailController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error ?? 'E-mail de recuperação enviado!')));
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar senha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: 'E-mail'), validator: Validators.validateEmail),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: loading ? null : _send, child: Text(loading ? 'Enviando...' : 'Enviar recuperação')),
          ]),
        ),
      ),
    );
  }
}
