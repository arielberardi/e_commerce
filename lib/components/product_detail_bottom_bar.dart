import 'package:e_commerce/components/color_selector.dart';
import 'package:e_commerce/components/quantity_selector.dart';
import 'package:e_commerce/components/ratting_stars.dart';
import 'package:e_commerce/components/size_selector.dart';
import 'package:e_commerce/models/cart_item_model.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetailBottomBar extends StatefulWidget {
  const ProductDetailBottomBar(this.product, {super.key});

  final Product product;

  @override
  State<ProductDetailBottomBar> createState() => _ProductDetailBottomBarState();
}

class _ProductDetailBottomBarState extends State<ProductDetailBottomBar> {
  int quantity = 1;
  String color = '';
  String size = '';

  String getTotalPrice() {
    return (widget.product.price * quantity).toStringAsFixed(2);
  }

  void addToCart() {
    final cartProvider = context.read<CartProvider>();

    cartProvider.add(CartItem(
      product: widget.product,
      color: color,
      size: size,
      quantity: quantity,
    ));

    Fluttertoast.showToast(
      msg: 'Added to the cart',
      gravity: ToastGravity.TOP,
    );
  }

  @override
  void initState() {
    // Set default values
    color = widget.product.colors.entries.elementAt(1).key;
    size = widget.product.sizes[1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.product.summary,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                RattingStars(
                  ratting: widget.product.ratting,
                  reviews: widget.product.reviews,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                QuantitySelector(
                  value: quantity,
                  min: 1,
                  max: 5,
                  onChange: (value) => setState(() => quantity = value),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'page.product_detail.available_stock'.tr(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'page.product_detail.size'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizeSelector(
              sizes: widget.product.sizes,
              onSelected: (value) => setState(() => size = value),
            ),
            ColorSelector(
              colors: widget.product.colors,
              onChange: (value) => setState(() => color = value),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'page.product_detail.description'.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 10),
        Text(
          widget.product.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Expanded(child: SizedBox(height: 25)),
        Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${getTotalPrice()}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
              AddToCartButton(onTap: addToCart),
            ],
          ),
        )
      ],
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
              Text(
                'page.product_detail.add_to_cart'.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
