import 'package:e_commerce/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDelete,
    required this.onRead,
  });

  final NotificationModel notification;
  final VoidCallback onDelete;
  final VoidCallback onRead;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            spacing: 1,
            flex: 1,
            onPressed: (context) => onDelete(),
            icon: Icons.delete_forever,
            foregroundColor: Colors.black,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          enabled: !notification.readed,
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: Icon(
            notification.getIcon(),
            color: notification.readed ? Colors.grey : Colors.black,
          ),
          onTap: onRead,
        ),
      ),
    );
  }
}
