// models/product.dart
class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  Rating rating;
  final String category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.category,
  });
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });
}
