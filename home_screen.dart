import 'package:flutter/material.dart';
import 'task_list_screen.dart'; // Pantalla para ver las tareas de una lista

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> taskLists = [
    'Lista 1',
    'Lista 2',
    'Lista 3',
  ]; // Listas de ejemplo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Listas')),
      body: ListView.builder(
        itemCount: taskLists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(taskLists[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TaskListScreen(listName: taskLists[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
