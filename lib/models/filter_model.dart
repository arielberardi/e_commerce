import 'package:flutter/material.dart';

class Filter {
  Filter({
    this.name,
    this.category,
    this.priceRange,
    this.ratting,
  }) : assert(
          name != null || category != null,
          'Either name or category must be provided',
        );

  String? name;
  String? category;
  RangeValues? priceRange;
  double? ratting;
}
