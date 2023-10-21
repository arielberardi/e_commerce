import 'package:e_commerce/models/product_model.dart';

class CartItem {
  CartItem({
    required this.product,
    required this.color,
    required this.size,
    required this.quantity,
  });

  final Product product;
  final String color;
  final String size;
  int quantity;
}
