import 'package:flutter/material.dart';
import 'package:client/widgets/create_list_form.dart';

class UrgentListsScreen extends StatelessWidget {
  const UrgentListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas Urgentes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CreateListButton(category: 'URGENT',),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
