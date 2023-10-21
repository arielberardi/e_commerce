import 'package:e_commerce/models/menu_item_model.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  const MenuItemWidget({
    super.key,
    required this.item,
  });

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            item.icon,
            color: Colors.black,
          ),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: const Icon(
          Icons.navigate_next,
          color: Colors.black,
        ),
      ),
    );
  }
}
