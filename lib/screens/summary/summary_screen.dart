import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/firestore_service.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});
  String _currency(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Resumo Financeiro')),
    body: StreamBuilder<List<TransactionModel>>(
      stream: FirestoreService.instance.streamTransactions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Erro: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final list = snapshot.data!;
        final income = list.where((e) => e.type == 'income').fold<double>(0, (s, e) => s + e.amount);
        final expense = list.where((e) => e.type == 'expense').fold<double>(0, (s, e) => s + e.amount);
        final balance = income - expense;
        return ListView(padding: const EdgeInsets.all(16), children: [
          Card(child: ListTile(leading: const Icon(Icons.arrow_downward), title: const Text('Total de Receitas'), subtitle: Text(_currency(income)))),
          Card(child: ListTile(leading: const Icon(Icons.arrow_upward), title: const Text('Total de Despesas'), subtitle: Text(_currency(expense)))),
          Card(child: ListTile(leading: const Icon(Icons.account_balance_wallet), title: const Text('Saldo Atual'), subtitle: Text(_currency(balance), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))),
        ]);
      },
    ),
  );
}
