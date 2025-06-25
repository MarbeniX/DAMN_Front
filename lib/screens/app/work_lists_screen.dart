import 'package:client/widgets/update_list_form.dart';
import 'package:flutter/material.dart';
import 'package:client/services/list_service.dart';
import 'package:client/widgets/create_list_form.dart';
import 'task_list_screen.dart';

class WorkListsScreen extends StatefulWidget {
  const WorkListsScreen({super.key});

  @override
  State<WorkListsScreen> createState() => _WorkListsScreenState();
}

class _WorkListsScreenState extends State<WorkListsScreen> {
  List<Map<String, dynamic>> workLists = [];

  @override
  void initState() {
    super.initState();
    _fetchLists();
  }

  Future<void> _fetchLists() async {
    final lists = await ListService.getListsByCategory('work');
    setState(() {
      workLists = lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas de Trabajo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreateListButton(
              category: 'WORK',
              onListCreated: _fetchLists, // <- Recarga listas al crear una nueva
            ),
            const SizedBox(height: 24),
            Expanded(
              child: workLists.isEmpty
                  ? const Center(child: Text('No hay listas'))
                  : ListView.builder(
                      itemCount: workLists.length,
                      itemBuilder: (context, index) {
                        final list = workLists[index];
                        return Card(
                          child: ListTile(
                            title: Text(list['listName'] ?? 'Sin nombre'),
                            subtitle: Text(list['description'] ?? ''),
                            leading: CircleAvatar(
                              backgroundColor: Color(
                                _hexToColor(list['listColor'] ?? '#808080'),
                              ),
                            ),
                          trailing: EditListButton(
                            list: list,
                            onListUpdated: _fetchLists, // Recarga listas al editar
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TaskListScreen(
                                  listId: list['_id'] ?? '',
                                  listName: list['listName'] ?? 'Sin nombre',
                                  listColor: Color(_hexToColor(list['listColor'])),
                                  listDescription: list['description'] ?? 'Sin descripción',
                                ),
                              ),
                            );
                          },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  int _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return int.parse(hex, radix: 16);
  }
}
