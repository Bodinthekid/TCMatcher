import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class EditProfileField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? prefixText;
  final int maxLines;

  const EditProfileField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          Expanded(
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              minLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                prefixText: prefixText,
                prefixStyle: const TextStyle(
                  color: AppColors.accentCyan,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}