import 'package:e_commerce/provider/address_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class AddressDialogForm extends StatefulWidget {
  const AddressDialogForm({
    super.key,
    this.edit = false,
    this.index,
    this.data,
  }) : assert(
          edit == false || (index != null && data != null),
          'Address can\'t be empty on edit form',
        );

  final bool edit;
  final BillingDetails? data;
  final int? index;

  @override
  State<AddressDialogForm> createState() => _AddressDialogFormState();
}

class _AddressDialogFormState extends State<AddressDialogForm> {
  final formKey = GlobalKey<FormBuilderState>();
  late String title;

  void onSubmit(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() != true) {
      return;
    }

    final value = formKey.currentState?.value;
    if (value == null) {
      return;
    }

    final provider = context.read<AddressProvider>();

    final address = BillingDetails(
      name: value['fullName'],
      phone: value['phone'],
      address: Address(
        line1: value['line1'],
        line2: '',
        city: value['city'],
        state: value['state'],
        country: value['country'],
        postalCode: value['postCode'],
      ),
    );

    if (widget.edit == true) {
      provider.update(widget.index!, address);
    } else {
      provider.add(address);
      if (provider.items.length == 1) {
        provider.setDefault(0);
      }
    }

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    if (widget.edit) {
      title = 'component.address_form.edit_title'.tr();
    } else {
      title = 'component.address_form.new_title'.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    late BillingDetails data;
    late Address address;

    if (widget.edit) {
      data = widget.data!;
      address = data.address!;
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: FormBuilder(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 25),
                DialogTextField(
                  name: 'fullName',
                  hintText: 'component.address_card.name'.tr(),
                  icon: Icons.person_outline,
                  autofocus: true,
                  initialValue: widget.edit ? data.name : null,
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  name: 'phone',
                  hintText: 'component.address_card.phone'.tr(),
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  initialValue: widget.edit ? data.phone : null,
                ),
                const SizedBox(height: 10),
                DialogTextField(
                  name: 'line1',
                  hintText: 'component.address_form.address'.tr(),
                  icon: Icons.pin_drop_outlined,
                  initialValue: widget.edit ? address.line1 : null,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: DialogTextField(
                        name: 'city',
                        hintText: 'component.address_card.city'.tr(),
                        initialValue: widget.edit ? address.city : null,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: DialogTextField(
                        name: 'state',
                        hintText: 'component.address_card.state'.tr(),
                        initialValue: widget.edit ? address.state : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: DialogTextField(
                        name: 'postCode',
                        hintText: 'component.address_card.post_code'.tr(),
                        uppercased: TextCapitalization.characters,
                        initialValue: widget.edit ? address.postalCode : null,
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: DialogTextField(
                        name: 'country',
                        hintText: 'component.address_card.country'.tr(),
                        initialValue: widget.edit ? address.country : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'component.address_form.cancel'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onSubmit(context),
                      child: Text('component.address_form.submit'.tr()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogTextField extends StatelessWidget {
  const DialogTextField({
    super.key,
    required this.name,
    required this.hintText,
    this.icon,
    this.autofocus = false,
    this.uppercased = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    this.initialValue,
  });

  final String name;
  final String hintText;
  final IconData? icon;
  final bool autofocus;
  final TextCapitalization uppercased;
  final TextInputType keyboardType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      autofocus: autofocus,
      autocorrect: false,
      textCapitalization: uppercased,
      keyboardType: keyboardType,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: icon == null ? null : Icon(icon),
        contentPadding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      validator: FormBuilderValidators.required(),
    );
  }
}
