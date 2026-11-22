import 'package:flutter/material.dart';
import 'store_community_models.dart';

class PlayerStoreCommunity {
  final String id;
  final String name;
  final String initials;
  final String? iconUrl;
  final Color accentColor;
  final int onlineCount;
  final int memberCount;
  final int unreadCount;
  final List<CommunityChannel> channels;
  final List<CommunityMember> members;
  final List<CommunityMessage> messages;

  const PlayerStoreCommunity({
    required this.id,
    required this.name,
    required this.initials,
    required this.accentColor,
    required this.onlineCount,
    required this.memberCount,
    required this.channels,
    required this.members,
    required this.messages,
    this.iconUrl,
    this.unreadCount = 0,
  });
}

class DirectMessageItem {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String timestamp;
  final String dateGroup;
  final String text;
  final bool isMe;

  const DirectMessageItem({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.timestamp,
    required this.dateGroup,
    required this.text,
    this.isMe = false,
  });
}

class DirectMessageThread {
  final String id;
  final String playerName;
  final String username;
  final String avatarUrl;
  final Color statusColor;
  final String statusLabel;
  final String favoriteGame;
  final String lastTime;
  final int unreadCount;
  final List<DirectMessageItem> messages;

  const DirectMessageThread({
    required this.id,
    required this.playerName,
    required this.username,
    required this.avatarUrl,
    required this.statusColor,
    required this.statusLabel,
    required this.favoriteGame,
    required this.lastTime,
    required this.messages,
    this.unreadCount = 0,
  });

  String get lastMessagePreview =>
      messages.isEmpty ? 'Start a conversation' : messages.last.text;
}