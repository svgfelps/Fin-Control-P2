import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/firestore_service.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  String _currency(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';
  String _date(DateTime d) => '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _edit(BuildContext context, TransactionModel t) async {
    final title = TextEditingController(text: t.title);
    final amount = TextEditingController(text: t.amount.toStringAsFixed(2));
    await showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Atualizar transação'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: title, decoration: const InputDecoration(labelText: 'Título')),
        const SizedBox(height: 12),
        TextField(controller: amount, decoration: const InputDecoration(labelText: 'Valor'), keyboardType: TextInputType.number),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(onPressed: () async {
          try {
            await FirestoreService.instance.updateTransaction(TransactionModel(
              id: t.id, title: title.text.trim(), amount: double.parse(amount.text.replaceAll(',', '.')), date: t.date,
              category: t.category, type: t.type, description: t.description, userId: t.userId,
            ));
            if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transação atualizada!'))); }
          } catch (e) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao atualizar: $e'))); }
        }, child: const Text('Salvar')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Transações em tempo real')),
    body: StreamBuilder<List<TransactionModel>>(
      stream: FirestoreService.instance.streamTransactions(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Erro ao recuperar dados: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final data = snapshot.data!;
        if (data.isEmpty) return const Center(child: Text('Nenhuma transação cadastrada.'));
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: data.length,
          itemBuilder: (context, i) {
            final t = data[i];
            final isIncome = t.type == 'income';
            return Card(child: ListTile(
              leading: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward, color: isIncome ? Colors.green : Colors.red),
              title: Text(t.title),
              subtitle: Text('${t.category} • ${_date(t.date)}\n${t.description}'),
              trailing: Wrap(children: [
                Text(_currency(t.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.edit), onPressed: () => _edit(context, t)),
                IconButton(icon: const Icon(Icons.delete), onPressed: () async => FirestoreService.instance.deleteTransaction(t.id)),
              ]),
            ));
          },
        );
      },
    ),
  );
}
