import 'package:e_commerce/components/product_tile.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({
    super.key,
    required this.title,
    required this.products,
  });

  final String title;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(title),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 0.9,
                children: List.generate(
                  products.length,
                  (index) => ProductTile(products[index]),
                ),
              ),
            ),
          ],
        ));
  }
}
