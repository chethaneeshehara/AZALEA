class AzaleaProduct {
  final String title;
  final String price;
  final String imageUrl;
  final String category;
  final double rating;
  final String? originalPrice;
  final String? discount;
  final String? badge;

  AzaleaProduct({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    this.originalPrice,
    this.discount,
    this.badge,
  });
}