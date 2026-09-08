import 'product.dart';

class CartItem {
  final AzaleaProduct product;
  String size;
  int quantity;

  CartItem({
    required this.product,
    this.size = 'M',
    this.quantity = 1,
  });

  double get numericPrice {
    return double.tryParse(
          product.price.replaceAll('\$', '').replaceAll(',', ''),
        ) ??
        0;
  }

  double get total => numericPrice * quantity;
}