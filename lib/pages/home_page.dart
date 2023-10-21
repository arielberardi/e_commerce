import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/product_card.dart';
import 'package:e_commerce/components/search_form.dart';
import 'package:e_commerce/components/slider_selector.dart';
import 'package:e_commerce/components/top_products_list.dart';
import 'package:e_commerce/models/filter_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/pages/product_detail_page.dart';
import 'package:e_commerce/pages/products_list_page.dart';
import 'package:e_commerce/services/auth_service.dart';
import 'package:e_commerce/services/product_category_service.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/utils/ui_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const kTestProductList = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageViewController = PageController();
  final categoriesNames = ProductCategoryService.getAllCategoriesNames();

  int currentCategoryIndex = 0;

  Product popularProduct = ProductService.getMostPopularProduct();

  void signOut(BuildContext context) async {
    UIUtil.showCircularSpinner(context);

    AuthService.signOut().then((_) {
      UIUtil.resetToRootPage(context);
    }).catchError((error) {
      UIUtil.closeDialog(context);

      UIUtil.showError(
        context,
        body: AuthService.parseError(error),
        title: 'error.title'.tr(),
      );
    });
  }

  List<String> getCategoriesNameLocalized() {
    return List.generate(categoriesNames.length, (index) {
      return 'page.home.categories.${categoriesNames[index]}'.tr();
    });
  }

  void onSliderSelected(int index) {
    setState(() => currentCategoryIndex = index);

    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  TopProductsList getCurrentTopWidget() {
    String category = categoriesNames[currentCategoryIndex];

    return TopProductsList(
        title: 'page.home.categories.top_$category'.tr(),
        items: ProductService.getTopProductsFromCategory(category),
        onViewAll: (context) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return ProductsListPage(filter: Filter(category: category));
            }),
          );
        });
  }

  void onSearchSubmit(Filter? filter) {
    if (filter == null) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ProductsListPage(filter: filter);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 5.0),
                Text(
                  'page.home.title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'page.home.sub_title'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20.0),
                SearchForm(onSubmit: onSearchSubmit),
                const SizedBox(height: 20.0),
                ProductCard(
                  product: popularProduct,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ProductDetailPage(popularProduct);
                      }),
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  'page.home.categories.title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10.0),
                SliderSelector(
                  items: getCategoriesNameLocalized(),
                  onSelected: onSliderSelected,
                ),
                const SizedBox(height: 20.0),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 1100,
                child: PageView.builder(
                  controller: pageViewController,
                  itemCount: categoriesNames.length,
                  itemBuilder: (context, index) => getCurrentTopWidget(),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.onTapMenu,
    required this.onTapAvatar,
  });

  final VoidCallback onTapMenu;
  final VoidCallback onTapAvatar;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrimaryIconButton(
                  icon: Icons.menu,
                  size: 20,
                  onPressed: onTapMenu,
                ),
                GestureDetector(
                  onTap: onTapAvatar,
                  child: const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      'https://placehold.co/200x200/png',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
