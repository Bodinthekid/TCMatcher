import 'package:flutter/material.dart';

String formatCommunityNow() {
  final now = TimeOfDay.now();
  final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
  final minute = now.minute.toString().padLeft(2, '0');
  return 'Today at $hour:$minute ${now.period == DayPeriod.am ? 'AM' : 'PM'}';
}