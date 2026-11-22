import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PlayerCardActions extends StatelessWidget {
  final VoidCallback onConnect;
  final VoidCallback onProfile;

  const PlayerCardActions({
    super.key,
    required this.onConnect,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: onConnect,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Connect',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 40,
          child: OutlinedButton(
            onPressed: onProfile,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: AppColors.cardBorder),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Profile'),
          ),
        ),
      ],
    );
  }
}