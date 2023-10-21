import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.billingDetails,
  });

  final stripe.BillingDetails billingDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressTextField(
              label: 'component.address_card.name'.tr(),
              text: billingDetails.name!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.email'.tr(),
              text: billingDetails.email!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.phone'.tr(),
              text: billingDetails.phone!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.street'.tr(),
              text: billingDetails.address!.line1!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.city'.tr(),
              text: billingDetails.address!.city!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.state'.tr(),
              text: billingDetails.address!.state!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.post_code'.tr(),
              text: billingDetails.address!.postalCode!,
            ),
            const SizedBox(height: 5),
            AddressTextField(
              label: 'component.address_card.country'.tr(),
              text: billingDetails.address!.country!,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: '$label: ',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        TextSpan(
          text: text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ]),
    );
  }
}
