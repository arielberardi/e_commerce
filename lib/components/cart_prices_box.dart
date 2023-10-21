import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartPricesBox extends StatelessWidget {
  const CartPricesBox({
    super.key,
    required this.total,
    required this.subtotal,
    required this.shipping,
    required this.itemsCount,
  });

  final double total;
  final double subtotal;
  final double shipping;
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'page.cart.subtotal'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: Colors.grey, height: 1),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'page.cart.shipping'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '\$${shipping.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(color: Colors.grey, height: 1),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'page.cart.total'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '($itemsCount item)  ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextSpan(
                    text: '\$${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
