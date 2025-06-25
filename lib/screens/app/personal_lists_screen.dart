import 'package:flutter/material.dart';
import 'package:client/services/list_service.dart';
import 'package:client/widgets/create_list_form.dart';

class PersonalListsScreen extends StatefulWidget {
  const PersonalListsScreen({super.key});

  @override
  State<PersonalListsScreen> createState() => _PersonalListsScreenState();
}

class _PersonalListsScreenState extends State<PersonalListsScreen> {
  List<Map<String, dynamic>> personalLists = [];

  @override
  void initState() {
    super.initState();
    _fetchLists();
  }

  Future<void> _fetchLists() async {
    final lists = await ListService.getListsByCategory('personal');
    setState(() {
      personalLists = lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listas Personales')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreateListButton(
              category: 'PERSONAL',
              onListCreated: _fetchLists, // <- Recarga listas al crear una nueva
            ),
            const SizedBox(height: 24),
            Expanded(
              child: personalLists.isEmpty
                  ? const Center(child: Text('No hay listas'))
                  : ListView.builder(
                      itemCount: personalLists.length,
                      itemBuilder: (context, index) {
                        final list = personalLists[index];
                        return Card(
                          child: ListTile(
                            title: Text(list['listName'] ?? 'Sin nombre'),
                            subtitle: Text(list['description'] ?? ''),
                            leading: CircleAvatar(
                              backgroundColor: Color(
                                _hexToColor(list['listColor'] ?? '#808080'),
                              ),
                            ),
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
