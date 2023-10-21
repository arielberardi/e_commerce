import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, favoriteProvider, child) {
        IconData icon = Icons.favorite_outline_sharp;

        if (favoriteProvider.isFavorited(product)) {
          icon = Icons.favorite_sharp;
        }

        return PrimaryIconButton(
          icon: icon,
          size: 15,
          padding: const EdgeInsets.all(2.5),
          onPressed: () {
            if (favoriteProvider.isFavorited(product)) {
              favoriteProvider.remove(product);

              Fluttertoast.showToast(
                msg: 'Removed from favorites',
                gravity: ToastGravity.TOP,
              );
            } else {
              favoriteProvider.add(product);

              Fluttertoast.showToast(
                msg: 'Add to favorites',
                gravity: ToastGravity.TOP,
              );
            }
          },
        );
      },
    );
  }
}
