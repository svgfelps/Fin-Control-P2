import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _currency(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final userName = auth.currentUser?.name ?? 'Usuário';
    final items = [
      ('Nova Receita', AppRoutes.addIncome, Icons.arrow_downward),
      ('Nova Despesa', AppRoutes.addExpense, Icons.arrow_upward),
      ('Transações', AppRoutes.transactions, Icons.receipt_long),
      ('Metas', AppRoutes.goals, Icons.flag),
      ('Pesquisa', AppRoutes.search, Icons.search),
      ('Resumo', AppRoutes.summary, Icons.account_balance_wallet),
      ('Orçamentos', AppRoutes.budgets, Icons.savings),
      ('Mercado Hoje', AppRoutes.reports, Icons.trending_up),
      ('Perfil', AppRoutes.profile, Icons.person),
      ('Sobre', AppRoutes.about, Icons.info_outline),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinControl'),
        actions: [IconButton(onPressed: () async { await auth.logout(); if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false); }, icon: const Icon(Icons.logout))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          StreamBuilder(
            stream: FirestoreService.instance.streamTransactions(),
            builder: (context, snapshot) {
              final list = snapshot.data ?? [];
              final income = list.where((e) => e.type == 'income').fold<double>(0, (s, e) => s + e.amount);
              final expense = list.where((e) => e.type == 'expense').fold<double>(0, (s, e) => s + e.amount);
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Olá, $userName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Saldo atual: ${_currency(income - expense)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Receitas: ${_currency(income)}  |  Despesas: ${_currency(expense)}'),
                  ]),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, i) => InkWell(
                onTap: () => Navigator.pushNamed(context, items[i].$2),
                child: Card(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(items[i].$3), const SizedBox(height: 8), Text(items[i].$1, textAlign: TextAlign.center)])),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
