import 'package:e_commerce/models/menu_item_model.dart';
import 'package:e_commerce/components/menu/menu_item_widget.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.items,
  });

  final List<MenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 15.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1.25, color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) => MenuItemWidget(
            item: items[index],
          ),
        ),
      ),
    );
  }
}
