import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil do Usuário')),
      body: user == null
          ? const Center(child: Text('Nenhum usuário logado.'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.person, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.displayName ?? 'Usuário',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(user.email ?? ''),
                  const SizedBox(height: 24),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text('E-mail'),
                      subtitle: Text(user.email ?? ''),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();

                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.login,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Sair'),
                  ),
                ],
              ),
            ),
    );
  }
}