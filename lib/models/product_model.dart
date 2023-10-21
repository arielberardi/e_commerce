class Product {
  const Product({
    required this.name,
    required this.summary,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.ratting,
    required this.reviews,
    required this.colors,
    required this.sizes,
  });

  final String name;
  final String summary;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final double ratting;
  final int reviews;
  final Map<String, int> colors;
  final List<String> sizes;
}
