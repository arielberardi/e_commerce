import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<Product> _products = [];
  List<Product> get products => _products;

  void add(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  bool isFavorited(Product product) {
    return _products.contains(product);
  }

  void toggle(Product product) {
    isFavorited(product) ? remove(product) : add(product);
  }
}
