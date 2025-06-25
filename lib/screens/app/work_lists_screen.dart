import 'package:flutter/material.dart';
import 'package:client/widgets/create_list_form.dart';

class WorkListsScreen extends StatelessWidget {
  const WorkListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas de Trabajo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CreateListButton(category: 'WORK',),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
