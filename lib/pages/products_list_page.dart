import 'package:e_commerce/components/bar_search_form_state.dart';
import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/models/filter_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key, required this.filter});

  final Filter filter;

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  bool isLoading = true;
  List<Product> filteredProducts = [];

  String generateTitle() {
    if (widget.filter.category != null && !widget.filter.category!.isNotEmpty) {
      return 'page.home.categories.${widget.filter.category}'.tr();
    }

    if (filteredProducts.isEmpty) {
      return 'page.products_list.empty'.tr();
    }

    return 'page.products_list.title'.tr();
  }

  void onSearchSubmit(String? value) {
    if (value == null || value.isEmpty) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) {
        return ProductsListPage(filter: widget.filter);
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    filteredProducts = ProductService.getAllProductsFiltered(widget.filter);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                  BarSearchForm(onSubmitted: onSearchSubmit),
                ],
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(25.0),
            sliver: SliverAppBar(
              toolbarHeight: 26,
              backgroundColor: Colors.transparent,
              actions: [
                Expanded(
                  child: Text(
                    generateTitle(),
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductTile(filteredProducts[index]),
                childCount: filteredProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
