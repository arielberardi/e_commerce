import 'package:e_commerce/components/buttons/secondary_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BarSearchForm extends StatefulWidget {
  const BarSearchForm({super.key, required this.onSubmitted});

  final Function(String? value) onSubmitted;

  @override
  State<BarSearchForm> createState() => _BarSearchFormState();
}

class _BarSearchFormState extends State<BarSearchForm> {
  bool open = false;
  double? width = 1;

  void toggleSearch() {
    debugPrint(open.toString());

    setState(() {
      open = !open;
      width = open ? 200 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SecondaryIconButton(
          icon: Icons.search,
          onPressed: toggleSearch,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.ease,
          child: SizedBox(
            width: width,
            child: FormBuilderTextField(
              enabled: open,
              name: 'search',
              autofocus: true,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: 'page.home.hint_search'.tr(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
