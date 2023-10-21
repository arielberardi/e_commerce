import 'package:e_commerce/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  final List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  void add(NotificationModel notification) {
    _notifications.add(notification);

    notifyListeners();
  }

  void remove(int index) {
    _notifications.removeAt(index);

    notifyListeners();
  }

  void removeAll() {
    _notifications.clear();

    notifyListeners();
  }

  void read(int index) {
    if (_notifications[index].readed) {
      return;
    }

    _notifications[index].readed = true;

    notifyListeners();
  }

  void readAll() {
    for(NotificationModel notification in _notifications) {
      notification.readed = true;
    }

    notifyListeners();
  }
}
