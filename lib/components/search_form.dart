import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/models/filter_model.dart';
import 'package:e_commerce/pages/filter_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({super.key, required this.onSubmit});

  final Function(Filter?) onSubmit;

  @override
  State<SearchForm> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  Filter currentFilter = Filter(name: '');

  void onFilterSubmit(Filter filter) {
    currentFilter = filter;
  }

  void onSearchSubmit(String? value) {
    if (value == null || value.isEmpty) {
      widget.onSubmit(null);
    } else {
      currentFilter.name = value;
      widget.onSubmit(currentFilter);
    }
  }

  void openFilterPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return FilterPage(currentFilter, onSubmit: onFilterSubmit);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(5.0, 0, 10.0, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: FormBuilderTextField(
              name: 'search',
              autofocus: false,
              autocorrect: false,
              onSubmitted: onSearchSubmit,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
                hintText: 'page.home.hint_search'.tr(),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        PrimaryIconButton(
          icon: Icons.tune,
          onPressed: () => openFilterPage(context),
        ),
      ],
    );
  }
}
