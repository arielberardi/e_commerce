import 'package:e_commerce/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;

  void add(CartItem item) {
    final int index = _getCartItemIndex(item);

    if (index == -1) {
      _items.add(item);
    } else {
      _items[index].quantity += item.quantity;
    }

    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);

    notifyListeners();
  }

  void update(int index, int quantity) {
    _items[index].quantity = quantity;

    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0.0;

    for (CartItem item in _items) {
      totalPrice += item.quantity * item.product.price;
    }

    return totalPrice;
  }

  double getTotalShippingPrice() {
    return 17.0;
  }

  int getItemsCount() {
    int itemCount = 0;

    for (CartItem item in _items) {
      itemCount += item.quantity;
    }

    return itemCount;
  }

  int _getCartItemIndex(CartItem item) {
    return _items.indexWhere((element) {
      return element.color == item.color &&
          element.size == item.size &&
          element.product.name == item.product.name;
    });
  }
}
