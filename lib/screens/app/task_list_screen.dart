import 'package:flutter/material.dart';
import 'package:client/widgets/create_task_form.dart';

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
      appBar: AppBar(title: Text(listName)),
      backgroundColor: listColor.withOpacity(1), // Aplica a toda la pantalla
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              listDescription,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            CreateTaskButton(listId: listId),
          ],
        ),
      ),
    );
  }
}
