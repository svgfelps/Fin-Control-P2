import 'package:flutter/material.dart';

import '../../core/routes/app_routes.dart';
import '../../models/goal_model.dart';
import '../../services/firestore_service.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});
  String _currency(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  Future<void> _edit(BuildContext context, GoalModel g) async {
    final current = TextEditingController(text: g.currentAmount.toStringAsFixed(2));
    await showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text('Atualizar meta'),
      content: TextField(controller: current, decoration: const InputDecoration(labelText: 'Valor atual'), keyboardType: TextInputType.number),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(onPressed: () async {
          try {
            await FirestoreService.instance.updateGoal(GoalModel(id: g.id, title: g.title, targetAmount: g.targetAmount, currentAmount: double.parse(current.text.replaceAll(',', '.')), deadline: g.deadline, priority: g.priority, userId: g.userId));
            if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meta atualizada!'))); }
          } catch (e) { if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao atualizar meta: $e'))); }
        }, child: const Text('Salvar')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Metas em tempo real')),
    floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.addGoal), child: const Icon(Icons.add)),
    body: StreamBuilder<List<GoalModel>>(
      stream: FirestoreService.instance.streamGoals(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text('Erro ao recuperar metas: ${snapshot.error}'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final goals = snapshot.data!;
        if (goals.isEmpty) return const Center(child: Text('Nenhuma meta cadastrada.'));
        return ListView.builder(padding: const EdgeInsets.all(12), itemCount: goals.length, itemBuilder: (context, i) {
          final g = goals[i];
          final progress = g.targetAmount == 0 ? 0.0 : (g.currentAmount / g.targetAmount).clamp(0.0, 1.0);
          return Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(title: Text(g.title), subtitle: Text('Prioridade: ${g.priority}\nAtual: ${_currency(g.currentAmount)} | Meta: ${_currency(g.targetAmount)}'), trailing: Wrap(children: [IconButton(icon: const Icon(Icons.edit), onPressed: () => _edit(context, g)), IconButton(icon: const Icon(Icons.delete), onPressed: () => FirestoreService.instance.deleteGoal(g.id))])),
            LinearProgressIndicator(value: progress),
          ])));
        });
      },
    ),
  );
}
