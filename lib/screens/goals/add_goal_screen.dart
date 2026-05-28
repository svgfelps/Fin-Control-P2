import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/validators.dart';
import '../../models/goal_model.dart';
import '../../services/firestore_service.dart';

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});
  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _target = TextEditingController();
  final _current = TextEditingController(text: '0');
  String _priority = 'Média';
  DateTime _deadline = DateTime.now().add(const Duration(days: 30));
  bool _loading = false;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirestoreService.instance.addGoal(GoalModel(
        id: '', title: _title.text.trim(), targetAmount: double.parse(_target.text.replaceAll(',', '.')),
        currentAmount: double.parse(_current.text.replaceAll(',', '.')), deadline: _deadline, priority: _priority,
        userId: FirebaseAuth.instance.currentUser!.uid,
      ));
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Meta inserida com sucesso!'))); Navigator.pop(context); }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao inserir meta: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nova Meta')),
    body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Form(key: _formKey, child: Column(children: [
      TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Título'), validator: (v) => Validators.validateRequired(v, 'Título')),
      const SizedBox(height: 16),
      TextFormField(controller: _target, decoration: const InputDecoration(labelText: 'Valor da meta'), keyboardType: TextInputType.number, validator: Validators.validateAmount),
      const SizedBox(height: 16),
      TextFormField(controller: _current, decoration: const InputDecoration(labelText: 'Valor atual'), keyboardType: TextInputType.number, validator: Validators.validateAmount),
      const SizedBox(height: 16),
      DropdownButtonFormField(initialValue: _priority, decoration: const InputDecoration(labelText: 'Prioridade'), items: ['Baixa', 'Média', 'Alta'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _priority = v!)),
      const SizedBox(height: 16),
      ListTile(title: Text('Prazo: ${_deadline.day}/${_deadline.month}/${_deadline.year}'), trailing: const Icon(Icons.calendar_month), onTap: () async { final picked = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2035), initialDate: _deadline); if (picked != null) setState(() => _deadline = picked); }),
      const SizedBox(height: 24),
      ElevatedButton(onPressed: _loading ? null : _save, child: Text(_loading ? 'Salvando...' : 'Salvar Meta')),
    ]))),
  );
}
