import 'package:flutter/material.dart';
import '../../shared/detailed_store_event_card.dart';

class StoreEventCard extends StatelessWidget {
  final String gameName;
  final IconData gameIcon;
  final Color gameColor;
  final String title;
  final String storeLocation;
  final String dateTime;
  final String spotsInfo;
  final String imageUrl;

  const StoreEventCard({
    super.key,
    required this.gameName,
    required this.gameIcon,
    required this.gameColor,
    required this.title,
    required this.storeLocation,
    required this.dateTime,
    required this.spotsInfo,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedStoreEventCard(
      gameName: gameName,
      gameIcon: gameIcon,
      gameColor: gameColor,
      title: title,
      storeLocation: storeLocation,
      dateTime: dateTime,
      spotsInfo: spotsInfo,
      imageUrl: imageUrl,
    );
  }
}