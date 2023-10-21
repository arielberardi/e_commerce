import 'dart:math';

import 'package:e_commerce/models/filter_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/utils/db_mock_util.dart';

class ProductService {
  static Product getMostPopularProduct() {
    Random random = Random();
    return kProductsCollection[random.nextInt(kProductsCollection.length - 1)];
  }

  static List<Product> getTopProductsFromCategory(String category) {
    List<Product> products = [];

    for (Product product in kProductsCollection) {
      if (product.category == category) {
        products.add(product);
      }

      if (products.length >= 8) {
        break;
      }
    }

    return products;
  }

  static List<Product> getAllProducts() {
    return kProductsCollection;
  }

  static List<Product> getAllProductsFromCategory(String category) {
    List<Product> products = [];

    for (Product product in kProductsCollection) {
      if (product.category == category) {
        products.add(product);
      }
    }

    return products;
  }

  static List<Product> getAllProductsFiltered(Filter filter) {
    return kProductsCollection.where((product) {
      return filter.category == null || product.category == filter.category;
    }).where((product) {
      return filter.name == null || product.name.contains(filter.name!);
    }).where((product) {
      if (filter.priceRange == null) return true;
      return product.price >= filter.priceRange!.start;
    }).where((product) {
      if (filter.priceRange == null) return true;
      return product.price <= filter.priceRange!.end;
    }).where((product) {
      return filter.ratting == null || product.ratting >= filter.ratting!;
    }).toList();
  }

  static double getAveragePriceByCategory(String category) {
    double prices = 0.0;

    for (Product product in kProductsCollection) {
      prices += product.price;
    }

    return prices / kProductsCollection.length;
  }

  static double getMaxPriceByCategory(String category) {
    double maxPrice = 0.0;

    for (Product product in kProductsCollection) {
      if (maxPrice < product.price) {
        maxPrice = product.price;
      }
    }

    return maxPrice;
  }
}
