import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class TournamentModalHeader extends StatelessWidget {
  final String? title;
  final String? badgeLabel;
  final VoidCallback onClose;

  const TournamentModalHeader({
    super.key,
    this.title,
    this.badgeLabel,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (badgeLabel != null)
          Chip(
            label: Text(
              badgeLabel!.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            backgroundColor: AppColors.primaryPurple,
          )
        else
          Text(
            title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white70),
          onPressed: onClose,
        ),
      ],
    );
  }
}