import 'package:flutter/material.dart';

enum NotificationType {
  general,
  news,
  tracking,
  product,
  message,
}

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
    this.readed = false,
  });

  final Map<NotificationType, IconData> _iconToTypeMap = {
    NotificationType.general: Icons.notifications_active,
    NotificationType.news: Icons.newspaper,
    NotificationType.tracking: Icons.shopify,
    NotificationType.product: Icons.production_quantity_limits_outlined,
    NotificationType.message: Icons.message,
  };

  final String title;
  final String body;
  final NotificationType type;
  final DateTime createdAt;
  bool readed;

  IconData? getIcon() {
    return _iconToTypeMap[type];
  }
}
