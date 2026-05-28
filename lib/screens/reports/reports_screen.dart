import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  String money(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotações em tempo real'),
      ),
      body: FutureBuilder<List<CurrencyQuote>>(
        future: api.getCurrencyQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar API: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final quotes = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final item = quotes[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const Icon(Icons.currency_exchange),
                  title: Text(item.name),
                  subtitle: Text(
                    'Máxima: ${money(item.high)} | Mínima: ${money(item.low)}\nAtualizado: ${item.date}',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        money(item.bid),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('${item.pctChange}%'),
                    ],
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