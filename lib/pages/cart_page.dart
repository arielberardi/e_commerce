import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/buttons/secondary_icon_button.dart';
import 'package:e_commerce/components/cart_item_tile.dart';
import 'package:e_commerce/pages/checkout_page.dart';
import 'package:e_commerce/pages/favorite_page.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void goToFavorite(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const FavoritePage();
      }),
    );
  }

  void goToCheckout(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const CheckoutPage();
      }),
    );
  }

  void onUpdateItem(value, index, provider) {
    if (value == 0) {
      provider.remove(index);

      Fluttertoast.showToast(
        msg: 'Product removed form the cart',
        gravity: ToastGravity.TOP,
      );
    } else {
      provider.update(index, value);

      Fluttertoast.showToast(
        msg: 'Cart Updated',
        gravity: ToastGravity.TOP,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'page.cart.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  SecondaryIconButton(
                    icon: Icons.favorite_border,
                    size: 25,
                    onPressed: () => goToFavorite(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Consumer<CartProvider>(builder: (context, cartProvider, child) {
              return Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) => CartItemTile(
                    item: cartProvider.items[index],
                    onUpdateItem: (value) => onUpdateItem(
                      value,
                      index,
                      cartProvider,
                    ),
                  ),
                  separatorBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 25),
            PrimaryButton(
              padding: EdgeInsets.zero,
              text: 'page.cart.button'.tr(),
              onPressed: () => goToCheckout(context),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
