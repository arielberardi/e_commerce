import 'package:e_commerce/components/address_card.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/cart_prices_box.dart';
import 'package:e_commerce/provider/cart_provider.dart';
import 'package:e_commerce/services/stripe_service.dart';
import 'package:e_commerce/utils/db_mock_util.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  void placeOrder(BuildContext context) async {
    UIUtil.showCircularSpinner(context);

    final cart = context.read<CartProvider>();
    double finalPrice = cart.getTotalPrice() + cart.getTotalShippingPrice();

    // TODO: Billing Details must come from currentUser
    try {
      await StripeService.createPaymentSheet(
        billingDetails: kUserAddresses[0],
        customerId: '',
        amount: (finalPrice * 100).toStringAsFixed(0),
        currency: 'USD',
      );

      if (!context.mounted) {
        return;
      }

      UIUtil.closeDialog(context);
      UIUtil.showSuccessDialog(
        context,
        icon: Icons.shopping_bag,
        title: 'page.checkout.dialog.title'.tr(),
        body: 'page.checkout.dialog.body'.tr(),
        buttonText: 'page.checkout.dialog.button'.tr(),
        onTap: () => UIUtil.resetToRootPage(context),
      );
    } on stripe.StripeException catch (e) {
      if (!context.mounted) {
        return;
      }

      UIUtil.closeDialog(context);

      if (e.error.stripeErrorCode != null) {
        UIUtil.showError(
          context,
          body: e.error.message,
          title: e.error.stripeErrorCode!,
        );
      } else if (e.error.declineCode != null) {
        UIUtil.showError(
          context,
          body: e.error.message,
          title: e.error.declineCode!,
        );
      }
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
                  PrimaryIconButton(
                    icon: Icons.arrow_back_rounded,
                    size: 20,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'page.checkout.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'page.checkout.delivery_address'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            AddressCard(billingDetails: kUserAddresses[0]),
            const SizedBox(height: 25),
            Text(
              'page.checkout.total'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Consumer<CartProvider>(builder: (context, cartProvider, child) {
              double totalPrice = cartProvider.getTotalPrice();
              double shippingPrice = cartProvider.getTotalShippingPrice();
              int itemCount = cartProvider.getItemsCount();

              return CartPricesBox(
                subtotal: totalPrice,
                shipping: shippingPrice,
                total: totalPrice + shippingPrice,
                itemsCount: itemCount,
              );
            }),
            const SizedBox(height: 25),
            PrimaryButton(
              padding: EdgeInsets.zero,
              height: 75,
              text: 'page.checkout.button'.tr(),
              onPressed: () => placeOrder(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
