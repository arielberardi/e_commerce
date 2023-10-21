import 'package:e_commerce/components/quantity_selector.dart';
import 'package:e_commerce/models/cart_item_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    this.height = 120,
    required this.item,
    required this.onUpdateItem
  });

  final double height;
  final CartItem item;
  final Function(int) onUpdateItem;

  String getTotalPrice() {
    return (item.product.price * item.quantity).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              item.product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  softWrap: false,
                ),
                Text(
                  item.product.summary,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'component.cart_item_tile.size'.tr(
                    args: [item.size],
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  'component.cart_item_tile.color'.tr(
                    args: [item.color],
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(child: SizedBox(height: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${getTotalPrice()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    QuantitySelector(
                      value: item.quantity,
                      min: 0,
                      max: 5,
                      onChange: onUpdateItem,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
