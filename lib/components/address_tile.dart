import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:popover/popover.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.details,
    this.selected = false,
    required this.onSetDefault,
    required this.onEdit,
    required this.onRemove,
  });

  final BillingDetails details;
  final bool selected;

  final VoidCallback onSetDefault;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 15.0,
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.person_2_outlined),
              const SizedBox(width: 10),
              Text(details.name!),
            ]),
            const SizedBox(height: 5.0),
            Row(children: [
              const Icon(Icons.pin_drop_outlined),
              const SizedBox(width: 10),
              Text('${details.address!.line1!}, ${details.address!.city!}'),
            ]),
            const SizedBox(height: 5.0),
            Row(children: [
              const Icon(Icons.phone_outlined),
              const SizedBox(width: 10),
              Text(details.phone!),
            ]),
          ],
        ),
        Positioned(
          right: 0,
          child: PopUpButton(items: [
            MenuItemButton(
              leadingIcon: Icon(
                Icons.check,
                color: selected ? Colors.grey[300] : Colors.green,
              ),
              onPressed: () {
                if (!selected) {
                  Navigator.of(context).pop();
                  onSetDefault();
                }
              },
              child: Text(
                'component.address_tile.add_default'.tr(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: selected ? Colors.grey[300] : Colors.black,
                    ),
              ),
            ),
            MenuItemButton(
              leadingIcon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
                onEdit();
              },
              child: Text(
                'component.address_tile.edit'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            MenuItemButton(
              leadingIcon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
                onRemove();
              },
              child: Text(
                'component.address_tile.remove'.tr(),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ]),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: selected ? const Icon(Icons.check) : Container(),
        ),
      ]),
    );
  }
}

class PopUpButton extends StatelessWidget {
  const PopUpButton({super.key, required this.items});

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => Column(children: items),
          width: 160,
          height: 150,
        );
      },
      child: Icon(Icons.more_horiz, color: Colors.grey[600]!),
    );
  }
}
