import 'package:e_commerce/components/favorite_button.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/pages/product_detail_page.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});

  final Product product;

  void goToDetailPage(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return ProductDetailPage(product);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => goToDetailPage(context),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(product.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              product.name,
              style: Theme.of(context).textTheme.titleSmall,
              softWrap: false,
            ),
            Text(
              product.summary,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        Positioned(
          right: 15,
          top: 10,
          child: FavoriteButton(product: product),
        ),
      ],
    );
  }
}
