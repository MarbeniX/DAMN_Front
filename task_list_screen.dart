import 'package:flutter/material.dart';
import '../models/task.dart'; // Modelo de tareas
import '../models/task_list.dart'; // Modelo de listas

class TaskListScreen extends StatefulWidget {
  final TaskList taskList; // Lista que se va a mostrar

  TaskListScreen({required this.taskList});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Agrega una nueva tarea a la lista actual
  void _addTask(String title) {
    setState(() {
      widget.taskList.tasks.add(Task(title: title));
    });
  }

  // Cambia el estado (hecho/no hecho) de una tarea
  void _toggleTask(Task task) {
    setState(() {
      task.toggleDone();
    });
  }

  // Elimina una tarea por índice
  void _deleteTask(int index) {
    setState(() {
      widget.taskList.tasks.removeAt(index);
    });
  }

  // Muestra un cuadro de diálogo para ingresar nueva tarea
  void _showAddTaskDialog() {
    String newTask = '';
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Nueva Tarea'),
            content: TextField(
              onChanged: (value) => newTask = value,
              decoration: InputDecoration(hintText: 'Descripción de la tarea'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (newTask.isNotEmpty) _addTask(newTask);
                  Navigator.pop(context); // Cierra el diálogo
                },
                child: Text('Agregar'),
              ),
            ],
          ),
    );
  }

  // Construye la pantalla con la lista de tareas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskList.name),
      ), // Título con el nombre de la lista
      body: ListView.builder(
        itemCount: widget.taskList.tasks.length,
        itemBuilder: (context, index) {
          final task = widget.taskList.tasks[index];
          return CheckboxListTile(
            title: Text(
              task.title,
              style: TextStyle(
                decoration:
                    task.isDone
                        ? TextDecoration.lineThrough
                        : null, // Tacha si está hecha
              ),
            ),
            value: task.isDone,
            onChanged: (_) => _toggleTask(task),
            secondary: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteTask(index), // Botón de borrar tarea
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog, // Botón para agregar tarea
        child: Icon(Icons.add),
      ),
    );
  }
}
