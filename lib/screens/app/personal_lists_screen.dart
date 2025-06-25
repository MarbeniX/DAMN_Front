import 'package:flutter/material.dart';
import 'package:client/widgets/create_list_form.dart';

class PersonalListsScreen extends StatelessWidget {
  const PersonalListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas Personales')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CreateListButton(category: 'PERSONAL',),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
