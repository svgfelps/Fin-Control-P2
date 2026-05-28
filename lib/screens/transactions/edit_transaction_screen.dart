import 'package:flutter/material.dart';

class EditTransactionScreen extends StatelessWidget {
  const EditTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Transação')),
      body: const Center(child: Text('Aqui você poderá editar uma transação.')),
    );
  }
}
