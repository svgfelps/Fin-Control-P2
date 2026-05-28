import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../services/firestore_service.dart';

class BudgetsScreen extends StatelessWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirestoreService.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orçamentos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addBudget);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: service.streamBudgets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Erro: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final budgets = snapshot.data ?? [];

          if (budgets.isEmpty) {
            return const Center(
              child: Text('Nenhum orçamento cadastrado'),
            );
          }

          return ListView.builder(
            itemCount: budgets.length,
            itemBuilder: (context, index) {
              final item = budgets[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text('Mês: ${item.month}'),
                  trailing: Text(
                    'R\$ ${item.limitAmount.toStringAsFixed(2)}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}