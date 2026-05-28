import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o Projeto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 38,
                child: Icon(Icons.account_balance_wallet, size: 38),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'FinControl',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Aplicativo de Controle Financeiro',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Objetivo do Aplicativo'),
            const SizedBox(height: 8),
            const Text(
              'O FinControl foi desenvolvido com o objetivo de ajudar o usuário '
              'a organizar sua vida financeira, permitindo o cadastro de receitas, '
              'despesas, metas e o acompanhamento do resumo financeiro de forma '
              'simples, intuitiva e acessível.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Integrantes da Equipe'),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Carlos Chen'),
                subtitle: Text('RA: 2840482421030'),
                
              ),
            ),
            const SizedBox(height: 0),
            const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Felipe Savegnago'),
                subtitle: Text('RA: 2840482421034'),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildSectionTitle('Informações Acadêmicas'),
            const SizedBox(height: 8),
            const Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.menu_book),
                    title: Text(
                      'Disciplina: Programação para Dispositivos Móveis',
                    ),
                    subtitle: Text('Desenvolvimento Mobile com Flutter'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Instituição'),
                    subtitle: Text('Fatec - Faculdade Tecnológica'),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('Professor'),
                    subtitle: Text('Rodrigo Plotze'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            _buildSectionTitle('Versão do Aplicativo'),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Versão'),
                subtitle: Text('1.0.0'),
              ),
            ),

            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Projeto acadêmico desenvolvido em Flutter.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
