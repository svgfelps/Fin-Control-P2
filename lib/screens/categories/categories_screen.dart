import 'package:flutter/material.dart';

import '../../core/utils/app_constants.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeCategories = AppConstants.incomeCategories;
    final expenseCategories = AppConstants.expenseCategories;

    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorias de Receita',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...incomeCategories.map(
              (category) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  title: Text(category),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Categorias de Despesa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...expenseCategories.map(
              (category) => Card(
                child: ListTile(
                  leading: const Icon(Icons.arrow_upward, color: Colors.red),
                  title: Text(category),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
