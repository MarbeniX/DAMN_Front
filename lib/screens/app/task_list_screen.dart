import 'package:flutter/material.dart';

class TaskListScreen extends StatelessWidget {
  final String listId;
  final String listName;
  final Color listColor;
  final String listDescription;

  const TaskListScreen({
    super.key,
    required this.listId,
    required this.listName,
    required this.listColor,
    required this.listDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tareas de $listName')),
      body: const Center(
        child: Text('Aquí se mostrarán las tareas'),
      ),
    );
  }
}
