import 'package:e_commerce/components/address_dialog_form.dart';
import 'package:e_commerce/components/address_tile.dart';
import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/provider/address_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  void openNewAddressForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddressDialogForm(),
      barrierDismissible: false,
    );
  }

  void openEditAddressForm(
    BuildContext context,
    int index,
    BillingDetails details,
  ) {
    showDialog(
      context: context,
      builder: (context) => AddressDialogForm(
        edit: true,
        index: index,
        data: details,
      ),
      barrierDismissible: false,
    );
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
                    'page.addresses.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 0),
          child: Consumer<AddressProvider>(builder: (context, value, child) {
            if (value.items.isEmpty) {
              return const Center(child: Text('No address found'));
            }

            return Column(
              children: List.generate(
                value.items.length,
                (index) => AddressTile(
                  details: value.items[index].details,
                  selected: value.items[index].selected,
                  onSetDefault: () => value.setDefault(index),
                  onEdit: () => openEditAddressForm(
                    context,
                    index,
                    value.items[index].details,
                  ),
                  onRemove: () => value.remove(index),
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNewAddressForm(context),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
