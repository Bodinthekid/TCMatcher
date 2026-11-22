import 'package:flutter/material.dart';

Future<bool> showDeleteTournamentDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text(
        'Delete Tournament',
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        'Are you sure you want to delete this tournament? This action cannot be undone.',
        style: TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    ),
  );

  return confirmed == true;
}