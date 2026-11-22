import 'package:flutter/material.dart';

class CommunityEmbed {
  final String title;
  final String description;
  final String? footer;
  final Color accentColor;
  final Map<String, String> fields;

  const CommunityEmbed({
    required this.title,
    required this.description,
    required this.accentColor,
    this.footer,
    this.fields = const {},
  });
}

class CommunityMessage {
  final String id;
  final String channelId;
  final String author;
  final String role;
  final String timestamp;
  final String dateGroup;
  final String avatarUrl;
  final String text;
  final bool isPinned;
  final String? imageUrl;
  final String? linkUrl;
  final CommunityEmbed? embed;

  const CommunityMessage({
    required this.id,
    required this.channelId,
    required this.author,
    required this.role,
    required this.timestamp,
    required this.dateGroup,
    required this.avatarUrl,
    required this.text,
    this.isPinned = false,
    this.imageUrl,
    this.linkUrl,
    this.embed,
  });
}

class CommunityChannel {
  final String id;
  final String name;
  final String topic;
  final String category;
  final bool isAnnouncement;
  final int unreadCount;

  const CommunityChannel({
    required this.id,
    required this.name,
    required this.topic,
    required this.category,
    this.isAnnouncement = false,
    this.unreadCount = 0,
  });
}

class CommunityMember {
  final String name;
  final String role;
  final String avatarUrl;
  final Color statusColor;
  final bool isOnline;

  const CommunityMember({
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.statusColor,
    required this.isOnline,
  });
}