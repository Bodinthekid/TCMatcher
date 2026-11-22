import 'package:flutter/material.dart';
import '../../../models/store_community_models.dart';
import '../../../theme/app_colors.dart';
import 'store_message_embed_card.dart';

class StoreMessageTile extends StatelessWidget {
  final CommunityMessage message;

  const StoreMessageTile({
    super.key,
    required this.message,
  });

  Color _roleColor(String role) {
    if (role == 'STORE') return AppColors.primaryPurple;
    if (role == 'MOD') return AppColors.accentCyan;
    return AppColors.textMuted;
  }

  @override
  Widget build(BuildContext context) {
    final showRole = message.role == 'STORE' || message.role == 'MOD';
    final badgeColor = _roleColor(message.role);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: Image.network(
              message.avatarUrl,
              width: 38,
              height: 38,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: 38,
                height: 38,
                color: AppColors.surfaceLight,
                child: const Icon(
                  Icons.person,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  runSpacing: 2,
                  children: [
                    Text(
                      message.author,
                      style: TextStyle(
                        color: message.role == 'STORE'
                            ? AppColors.accentCyan
                            : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (showRole)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1.5,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          message.role,
                          style: TextStyle(
                            color: badgeColor,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    Text(
                      message.timestamp,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message.text,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13.8,
                    height: 1.38,
                  ),
                ),
                if (message.linkUrl != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    message.linkUrl!,
                    style: const TextStyle(
                      color: AppColors.accentCyan,
                      fontSize: 12.5,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.accentCyan,
                    ),
                  ),
                ],
                if (message.imageUrl != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      message.imageUrl!,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        height: 120,
                        color: AppColors.surfaceLight,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.image_outlined,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ],
                if (message.embed != null)
                  StoreMessageEmbedCard(embed: message.embed!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}