import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/provider/favorite_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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
                    'page.favorites.title'.tr(),
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
        child: Consumer<FavoriteProvider>(
          builder: (context, favoriteProvider, widget) => GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.65,
            children: List.generate(
              favoriteProvider.products.length,
              (index) => ProductTile(favoriteProvider.products[index]),
            ),
          ),
        ),
      ),
    );
  }
}
