import 'dart:math';
import 'package:e_commerce/models/product_category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

const List<ProductCategory> kProductCategoriesCollection = [
  ProductCategory('dresses'),
  ProductCategory('jackets'),
  ProductCategory('jeans'),
  ProductCategory('shoes'),
  ProductCategory('trousers')
];

const List<String> shoesSizes = [
  '35',
  '36',
  '37',
  '38',
  '39',
  '40',
  '41',
  '42',
  '43',
  '44',
];

const List<String> clotheSizes = [
  'XS',
  'S',
  'M',
  'L',
  'XL',
  'XLL',
];

List<Product> kProductsCollection = List.generate(150, (index) {
  Random random = Random();
  int categoryIndex = random.nextInt(kProductCategoriesCollection.length);

  return Product(
    name: 'Axel Arigato',
    summary: 'Clean 90 Triple Sneakers',
    price: random.nextDouble() * 1000.0,
    imageUrl: 'https://placehold.co/400x400/png',
    category: kProductCategoriesCollection[categoryIndex].name,
    ratting: random.nextDouble() * 5.0,
    reviews: random.nextInt(1000),
    description: 'The Axel Arigato Clean 90 Triple Sneakers combine minimalist '
        'aesthetics with high-quality craftsmanship. These sneakers '
        'feature a clean and versatile design, making them a must-have '
        'for your casual wardrobe.',
    colors: {
      'Red': 0xFFF44336,
      'White': 0xFFFFFFFF,
      'Black': 0xFF000000,
      'Blue': 0xFF2196F3,
      'BlueGrey': 0xFF607D8B,
      'BlueAccent': 0xFF448AFF,
    },
    sizes: random.nextBool() ? clotheSizes : shoesSizes,
  );
});

const List<BillingDetails> kUserAddresses = [
  BillingDetails(
    email: 'ariel.berardi@gmail.com', // Account Details
    name: 'Ariel Berardi', // Account Details
    phone: '+447909303246', // Account Details
    address: Address(
      // Address Details
      city: 'Reading',
      country: 'United Kingdom',
      line1: '60 Rodway Road',
      line2: '',
      postalCode: 'RG30 6DT',
      state: 'Berkshire',
    ),
  ),
];
