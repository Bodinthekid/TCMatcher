import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class StatusOption {
  final String label;
  final Color color;
  final Color bg;
  const StatusOption(this.label, this.color, this.bg);
}

const List<StatusOption> kStatusOptions = [
  StatusOption('Online', AppColors.statusOnline, Color(0xFF11352B)),
  StatusOption('Available to Play', AppColors.statusAvailable, Color(0xFF282254)),
  StatusOption('Offline', AppColors.statusOffline, AppColors.surfaceLight),
];

void showProfileStatusSheet({
  required BuildContext context,
  required String currentLabel,
  required ValueChanged<StatusOption> onSelect,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Change Status',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...kStatusOptions.map((opt) {
            final selected = currentLabel == opt.label;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(radius: 7, backgroundColor: opt.color),
              title: Text(
                opt.label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
              trailing: selected
                  ? const Icon(Icons.check_rounded, color: AppColors.accentCyan)
                  : null,
              onTap: () {
                onSelect(opt);
                Navigator.pop(ctx);
              },
            );
          }),
        ],
      ),
    ),
  );
}