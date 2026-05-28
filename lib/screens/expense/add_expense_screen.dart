import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/utils/app_constants.dart';
import '../../core/utils/validators.dart';
import '../../models/transaction_model.dart';
import '../../services/firestore_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();
  final _description = TextEditingController();
  String? _category;
  bool _loading = false;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      await FirestoreService.instance.addTransaction(TransactionModel(
        id: '', title: _title.text.trim(), amount: double.parse(_amount.text.replaceAll(',', '.')), date: DateTime.now(),
        category: _category!, type: 'expense', description: _description.text.trim(), userId: FirebaseAuth.instance.currentUser!.uid,
      ));
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Despesa inserida com sucesso!'))); Navigator.pop(context); }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao inserir: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nova Despesa')),
    body: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Form(key: _formKey, child: Column(children: [
      TextFormField(controller: _title, decoration: const InputDecoration(labelText: 'Título'), validator: (v) => Validators.validateRequired(v, 'Título')),
      const SizedBox(height: 16),
      TextFormField(controller: _amount, decoration: const InputDecoration(labelText: 'Valor'), keyboardType: TextInputType.number, validator: Validators.validateAmount),
      const SizedBox(height: 16),
      DropdownButtonFormField(initialValue: _category, decoration: const InputDecoration(labelText: 'Categoria'), items: AppConstants.expenseCategories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _category = v), validator: (v) => v == null ? 'Selecione uma categoria.' : null),
      const SizedBox(height: 16),
      TextFormField(controller: _description, decoration: const InputDecoration(labelText: 'Observação'), validator: (v) => Validators.validateRequired(v, 'Observação')),
      const SizedBox(height: 24),
      ElevatedButton(onPressed: _loading ? null : _save, child: Text(_loading ? 'Salvando...' : 'Salvar Despesa')),
    ]))),
  );
}
