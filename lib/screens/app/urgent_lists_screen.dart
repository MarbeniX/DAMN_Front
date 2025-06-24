import 'package:flutter/material.dart';

class UrgentListsScreen extends StatelessWidget {
  const UrgentListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas Personales')),
      body: const Center(child: Text('Aquí van las listas personales')),
    );
  }
}
