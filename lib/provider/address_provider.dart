import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class AddressCardDetails {
  AddressCardDetails(this.details, this.selected);

  BillingDetails details;
  bool selected;
}

class AddressProvider extends ChangeNotifier {
  final List<AddressCardDetails> _items = [];
  List<AddressCardDetails> get items => _items;

  void add(BillingDetails details) {
    final item = AddressCardDetails(details, false);
    final int index = _getBillingDetailsIndex(item);

    if (index != -1) {
      return;
    }

    _items.add(item);
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);

    notifyListeners();
  }

  void setDefault(int index) {
    _removeDefaultSelected();

    _items[index].selected = true;
    notifyListeners();
  }

  void update(int index, BillingDetails details) {
    _items[index].details = details;

    notifyListeners();
  }

  int _getBillingDetailsIndex(AddressCardDetails item) {
    return _items.indexWhere((element) {
      return element.details.name == item.details.name &&
          element.details.phone == item.details.phone &&
          element.details.address?.line1 == item.details.address?.line1;
    });
  }

  void _removeDefaultSelected() {
    int currentIndex = _items.indexWhere((element) => element.selected == true);

    if (currentIndex != -1) {
      _items[currentIndex].selected = false;
    }
  }
}
