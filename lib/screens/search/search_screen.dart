import 'package:flutter/material.dart';

import '../../models/transaction_model.dart';
import '../../services/firestore_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _term = TextEditingController();
  String _orderBy = 'date';
  bool _loading = false;
  List<TransactionModel> _results = [];

  String _currency(double v) => 'R\$ ${v.toStringAsFixed(2).replaceAll('.', ',')}';

  Future<void> _search() async {
    setState(() => _loading = true);
    try {
      final result = await FirestoreService.instance.searchTransactions(term: _term.text, orderBy: _orderBy);
      setState(() => _results = result);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro na pesquisa: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _search();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pesquisa de Dados')),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(controller: _term, decoration: InputDecoration(labelText: 'Pesquisar por título', suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: _search)), onSubmitted: (_) => _search()),
        const SizedBox(height: 12),
        DropdownButtonFormField(initialValue: _orderBy, decoration: const InputDecoration(labelText: 'Ordenar por'), items: const [
          DropdownMenuItem(value: 'date', child: Text('Data mais recente')),
          DropdownMenuItem(value: 'titleLower', child: Text('Ordem alfabética')),
          DropdownMenuItem(value: 'amount', child: Text('Maior valor')),
        ], onChanged: (v) { setState(() => _orderBy = v!); _search(); }),
        const SizedBox(height: 16),
        if (_loading) const LinearProgressIndicator(),
        Expanded(child: _results.isEmpty ? const Center(child: Text('Nenhum resultado.')) : ListView.builder(itemCount: _results.length, itemBuilder: (context, i) {
          final t = _results[i];
          return Card(child: ListTile(title: Text(t.title), subtitle: Text('${t.category} • ${t.type}'), trailing: Text(_currency(t.amount))));
        })),
      ]),
    ),
  );
}
