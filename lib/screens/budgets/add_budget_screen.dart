import 'package:flutter/material.dart';

import '../../models/budget_model.dart';
import '../../services/firestore_service.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  State<AddBudgetScreen> createState() =>
      _AddBudgetScreenState();
}

class _AddBudgetScreenState
    extends State<AddBudgetScreen> {

  final name = TextEditingController();
  final value = TextEditingController();
  final month = TextEditingController();

  bool loading = false;

  Future save() async {

    setState(() {
      loading = true;
    });

    await FirestoreService.instance
        .addBudget(

      BudgetModel(
        name: name.text,

        limitAmount:
            double.parse(
              value.text,
            ),

        spentAmount: 0,

        month:
            month.text,

        userId:
            FirestoreService
                .instance
                .uid,
      ),

    );

    if (mounted) {

      Navigator.pop(
        context,
      );

    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          'Novo orçamento',
        ),
      ),

      body:
          Padding(

        padding:
            const EdgeInsets.all(
          16,
        ),

        child:
            Column(

          children: [

            TextField(
              controller:
                  name,

              decoration:
                  const InputDecoration(
                labelText:
                    'Nome',
              ),
            ),

            TextField(
              controller:
                  value,

              decoration:
                  const InputDecoration(
                labelText:
                    'Valor',
              ),
            ),

            TextField(
              controller:
                  month,

              decoration:
                  const InputDecoration(
                labelText:
                    'Mês',
              ),
            ),

            const SizedBox(
              height:
                  20,
            ),

            ElevatedButton(

              onPressed:
                  loading
                      ? null
                      : save,

              child:
                  const Text(
                'Salvar',
              ),

            )

          ],

        ),

      ),

    );
  }
}