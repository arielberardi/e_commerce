import 'package:e_commerce/components/buttons/secondary_icon_button.dart';
import 'package:e_commerce/components/notification_card.dart';
import 'package:e_commerce/provider/notification_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.read<NotificationProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'page.notifications.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  Row(children: [
                    SecondaryIconButton(
                      icon: Icons.mark_chat_read_outlined,
                      size: 25,
                      onPressed: () => notificationProvider.readAll()
                    ),
                    SecondaryIconButton(
                      icon: Icons.delete_outlined,
                      size: 25,
                      onPressed: () => notificationProvider.removeAll(),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProv, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: notificationProv.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationProv.notifications[index];
                return NotificationCard(
                  notification: notification,
                  onDelete: () => notificationProv.remove(index),
                  onRead: () => notificationProv.read(index),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
