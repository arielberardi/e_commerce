import 'package:e_commerce/components/buttons/primary_icon_button.dart';
import 'package:e_commerce/components/favorite_button.dart';
import 'package:e_commerce/components/product_detail_bottom_bar.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/components/image_slider.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                  FavoriteButton(product: product),
                ],
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            height: 500,
            child: ImageSlider(imageUrls: [product.imageUrl]),
          ),
          Column(
            children: [
              Expanded(child: Container()),
              Container(
                height: 400,
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0),
                    bottom: Radius.zero,
                  ),
                  color: Colors.white,
                ),
                child: ProductDetailBottomBar(product),
              ),
            ],
          )
        ],
      ),
    );
  }
}
