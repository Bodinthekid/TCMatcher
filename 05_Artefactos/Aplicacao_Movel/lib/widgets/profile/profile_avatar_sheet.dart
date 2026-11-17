import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

const List<String> _presetAvatars = [
  'https://i.pravatar.cc/150?img=47',
  'https://i.pravatar.cc/150?img=11',
  'https://i.pravatar.cc/150?img=12',
  'https://i.pravatar.cc/150?img=33',
  'https://i.pravatar.cc/150?img=5',
  'https://i.pravatar.cc/150?img=60',
  'https://i.pravatar.cc/150?img=68',
  'https://i.pravatar.cc/150?img=32',
];

void showProfileAvatarSheet({
  required BuildContext context,
  required String currentUrl,
  required ValueChanged<String> onSelect,
}) {
  final controller = TextEditingController();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (ctx) {
      return Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          24,
          20,
          MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: _presetAvatars.map((url) {
                final selected = currentUrl == url;

                return GestureDetector(
                  onTap: () {
                    onSelect(url);
                    Navigator.pop(ctx);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? AppColors.accentCyan
                            : Colors.transparent,
                        width: 2.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
              ),
              decoration: InputDecoration(
                hintText: 'Or paste an image URL here...',
                hintStyle: const TextStyle(
                  color: AppColors.textMuted,
                ),
                filled: true,
                fillColor: AppColors.surfaceLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.accentCyan,
                  ),
                  onPressed: () {
                    final url = controller.text.trim();

                    if (url.isEmpty) {
                      return;
                    }

                    onSelect(url);
                    Navigator.pop(ctx);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}