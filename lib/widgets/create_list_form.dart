import 'package:flutter/material.dart';
import 'package:client/services/list_service.dart';

const Map<String, String> colorList = {
  'RED': '#FF0000',
  'ORANGE': '#FFA500',
  'YELLOW': '#FFFF00',
  'GREEN': '#008000',
  'BLUE': '#0000FF',
  'PURPLE': '#800080',
  'PINK': '#FFC0CB',
  'BROWN': '#A52A2A',
  'GRAY': '#808080',
};

class CreateListButton extends StatelessWidget {
  
  final VoidCallback? onListCreated;

  const CreateListButton({super.key, this.onListCreated});

  // Helper to convert hex string like "#FF0000" to int for Color
  static int _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // add alpha if missing
    }
    return int.parse(hex, radix: 16);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showCreateListDialog(context),
      child: const Text('Crear una lista'),
    );
  }

  void _showCreateListDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();

    String selectedColorKey = colorList.keys.first; // por defecto

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Nueva Lista'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) =>
                    value == null || value.trim().isEmpty ? 'Requerido' : null,
              ),
              DropdownButtonFormField<String>(
                value: selectedColorKey,
                decoration: const InputDecoration(labelText: 'Color de la lista'),
                items: colorList.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Color(_hexToColor(entry.value)),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Text(entry.key),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    selectedColorKey = value;
                  }
                },
              ),
            ],
          ),
        ),
        
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final formData = {
                  'name': _nameController.text.trim(),
                  'description': _descriptionController.text.trim(),
                };

                final response = await ListService.createList(formData);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response['message'])),
                );

                if (response['success']) {
                  Navigator.pop(context); // Cierra el diálogo
                  if (onListCreated != null) onListCreated!();
                }
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }
}
