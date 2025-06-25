import 'package:flutter/material.dart';
import 'package:client/services/list_service.dart';

class DeleteListDialog extends StatelessWidget {
  final String listId;
  final VoidCallback? onDeleted;

  const DeleteListDialog({
    super.key,
    required this.listId,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Eliminar lista?'),
      content: const Text('¿Estás seguro de que deseas eliminar esta lista? Esta acción no se puede deshacer.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancelar
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            final response = await ListService.deleteList(listId);
            Navigator.of(context).pop(); // Cierra el dialog
            if (onDeleted != null) onDeleted!(); // Notifica al padre
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}
