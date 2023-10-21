import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TopProductsList extends StatelessWidget {
  const TopProductsList({
    super.key,
    required this.title,
    required this.items,
    required this.onViewAll,
  });

  final String title;
  final List<Product> items;
  final Function(BuildContext context) onViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            GestureDetector(
              onTap: () => onViewAll(context),
              child: Text('component.top_products_list.view_all'.tr()),
            ),
          ],
        ),
        Expanded(
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.65,
            children: List.generate(
              items.length,
              (index) => ProductTile(items[index]),
            ),
          ),
        ),
      ],
    );
  }
}
