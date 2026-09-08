import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../data/products.dart';

// ============================================================
// AZALEA STORE
// ============================================================

class AzaleaStore extends ChangeNotifier {
final List<AzaleaProduct> products = azaleaProducts;
  

  final Set<String> wishlist = {};

  final List<CartItem> cart = [];

  bool isWishlisted(AzaleaProduct product) {
    return wishlist.contains(product.title);
  }

  void toggleWishlist(AzaleaProduct product) {
    if (wishlist.contains(product.title)) {
      wishlist.remove(product.title);
    } else {
      wishlist.add(product.title);
    }

    notifyListeners();
  }

  void addToCart(
    AzaleaProduct product, {
    String size = 'M',
    int quantity = 1,
  }) {
    final existingIndex = cart.indexWhere(
      (item) =>
          item.product.title == product.title && item.size == size,
    );

    if (existingIndex != -1) {
      cart[existingIndex].quantity += quantity;
    } else {
      cart.add(
        CartItem(
          product: product,
          size: size,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cart.length) {
      cart[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cart.length) {
      if (cart[index].quantity > 1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      notifyListeners();
    }
  }

  int get cartCount {
    int count = 0;

    for (final item in cart) {
      count += item.quantity;
    }

    return count;
  }

  double get subtotal {
    double total = 0;

    for (final item in cart) {
      total += item.total;
    }

    return total;
  }

  double get delivery {
    if (cart.isEmpty) {
      return 0;
    }

    return subtotal >= 100 ? 0 : 8;
  }

  double get total {
    return subtotal + delivery;
  }
}