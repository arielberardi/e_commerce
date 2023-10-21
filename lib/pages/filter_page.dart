import 'package:e_commerce/components/buttons/category_button.dart';
import 'package:e_commerce/components/buttons/primary_button.dart';
import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/ratting_checkbox.dart';
import 'package:e_commerce/models/filter_model.dart';
import 'package:e_commerce/services/product_category_service.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterPage extends StatefulWidget {
  const FilterPage(this.currentFilter, {super.key, required this.onSubmit});

  final Filter currentFilter;
  final Function(Filter) onSubmit;

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int categorySelected = 0;
  SfRangeValues priceRange = const SfRangeValues(0.0, 0.0);
  int ratting = 1;

  List<String> categories = [];
  double categoryMaxPrice = 0.0;

  List<Widget> generateCategoryButtons() {
    return List.generate(categories.length, (index) {
      return SizedBox(
        height: 30,
        child: CategoryButton(
          name: 'page.home.categories.${categories[index]}'.tr(),
          selected: categorySelected == index,
          onTap: () => setState(() => categorySelected = index),
        ),
      );
    });
  }

  void updatePriceRange(SfRangeValues value) {
    setState(() => priceRange = value);
  }

  void updateRatting(bool value, int index) {
    if (value == true) {
      setState(() => ratting = index);
    }
  }

  void onSubmitFilter() {
    widget.currentFilter.category = categories[categorySelected];
    widget.currentFilter.ratting = ratting.toDouble();
    widget.currentFilter.priceRange = RangeValues(
      priceRange.start,
      priceRange.end,
    );

    widget.onSubmit(widget.currentFilter);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    categories = ProductCategoryService.getAllCategoriesNames();
    categoryMaxPrice = ProductService.getMaxPriceByCategory(
      categories[categorySelected],
    );
    priceRange = SfRangeValues(0.0, categoryMaxPrice);

    String? categoryName = widget.currentFilter.category;
    if (categoryName != null && categoryName.isNotEmpty) {
      categorySelected = categories.indexWhere((e) => e == categoryName);
    }

    RangeValues? range = widget.currentFilter.priceRange;
    if (range != null && range.start != range.end) {
      priceRange = SfRangeValues(range.start, range.end);
    }

    if (widget.currentFilter.ratting != null) {
      ratting = widget.currentFilter.ratting!.toInt();
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
                    'page.filter.title'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'page.filter.categories'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            Wrap(
              runSpacing: 10.0,
              children: generateCategoryButtons(),
            ),
            const SizedBox(height: 25.0),
            Text(
              'page.filter.price_range'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SfRangeSlider(
              min: 0.0,
              max: categoryMaxPrice,
              values: priceRange,
              onChanged: updatePriceRange,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              interval: categoryMaxPrice / 2,
              labelPlacement: LabelPlacement.onTicks,
              numberFormat: NumberFormat('\$'),
            ),
            const SizedBox(height: 25.0),
            Text(
              'page.filter.ratting'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(5, (index) {
                return RattinCheckbox(
                  number: 5 - index,
                  value: ratting == 5 - index,
                  onChanged: (value) => updateRatting(value!, 5 - index),
                );
              }),
            ),
            const Expanded(child: SizedBox(height: 25.0)),
            PrimaryButton(
              text: 'page.filter.button_apply'.tr(),
              padding: EdgeInsets.zero,
              onPressed: onSubmitFilter,
            ),
            const SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
