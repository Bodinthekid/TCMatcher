import 'package:flutter/material.dart';
import '../../models/player_community_models.dart';
import '../../theme/app_colors.dart';
import 'community_date_divider.dart';
import 'dm_chat_header.dart';
import 'dm_input_bar.dart';
import 'dm_message_row.dart';

class CommunityDmChatView extends StatelessWidget {
  final DirectMessageThread thread;
  final TextEditingController messageController;
  final VoidCallback onBack;
  final VoidCallback onSend;

  const CommunityDmChatView({
    super.key,
    required this.thread,
    required this.messageController,
    required this.onBack,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DmChatHeader(thread: thread, onBack: onBack),
        Expanded(
          child: thread.messages.isEmpty
              ? Center(
                  child: Text(
                    'Say hi to @${thread.username}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13.5,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: thread.messages.length,
                  itemBuilder: (_, index) {
                    final item = thread.messages[index];
                    final showDate = index == 0 ||
                        thread.messages[index - 1].dateGroup != item.dateGroup;

                    return Column(
                      children: [
                        if (showDate)
                          CommunityDateDivider(label: item.dateGroup),
                        DmMessageRow(item: item),
                      ],
                    );
                  },
                ),
        ),
        DmInputBar(
          controller: messageController,
          username: thread.username,
          onSend: onSend,
        ),
      ],
    );
  }
}