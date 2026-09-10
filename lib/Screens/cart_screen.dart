import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/cart_item.dart';
// ============================================================
// CART SCREEN
// ============================================================

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Your Bag',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Review your selected items',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (azaleaStore.cartCount >
                      0)
                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration:
                          BoxDecoration(
                        color: blushPink,
                        borderRadius:
                            BorderRadius
                                .circular(20),
                      ),
                      child: Text(
                        '${azaleaStore.cartCount} items',
                        style:
                            const TextStyle(
                          color: azaleaPink,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 25),

              if (azaleaStore.cart.isEmpty)
                _emptyCart()
              else ...[
                ...List.generate(
                  azaleaStore.cart.length,
                  (index) {
                    return _cartItem(
                      context,
                      index,
                      azaleaStore.cart[index],
                    );
                  },
                ),

                const SizedBox(height: 25),

                _orderSummary(),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Checkout feature coming soon ✨',
                          ),
                          backgroundColor:
                              azaleaPink,
                          behavior:
                              SnackBarBehavior
                                  .floating,
                        ),
                      );
                    },
                    style: ElevatedButton
                        .styleFrom(
                      backgroundColor:
                          azaleaPink,
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(15),
                      ),
                    ),
                    child: const Text(
                      'PROCEED TO CHECKOUT',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _emptyCart() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 120),
      child: Center(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(24),
              decoration:
                  const BoxDecoration(
                color: blushPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: azaleaPink,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Bag is Empty',
              style: TextStyle(
                fontSize: 23,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add something beautiful to your bag\nand it will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItem(
    BuildContext context,
    int index,
    CartItem item,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(13),
            child: Image.network(
              item.product.imageUrl,
              width: 95,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w600,
                          color:
                              darkCharcoal,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        azaleaStore
                            .removeFromCart(
                                index);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  item.product.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color: azaleaPink,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration:
                      BoxDecoration(
                    color: blushPink,
                    borderRadius:
                        BorderRadius.circular(
                            7),
                  ),
                  child: Text(
                    'Size: ${item.size}',
                    style:
                        const TextStyle(
                      fontSize: 11,
                      color: darkCharcoal,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    Container(
                      height: 38,
                      decoration:
                          BoxDecoration(
                        color: warmIvory,
                        borderRadius:
                            BorderRadius
                                .circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding:
                                EdgeInsets.zero,
                            onPressed: () {
                              azaleaStore
                                  .decreaseQuantity(
                                      index);
                            },
                            icon:
                                const Icon(
                              Icons.remove,
                              size: 17,
                            ),
                          ),
                          Text(
                            item.quantity
                                .toString(),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          IconButton(
                            padding:
                                EdgeInsets.zero,
                            onPressed: () {
                              azaleaStore
                                  .increaseQuantity(
                                      index);
                            },
                            icon:
                                const Icon(
                              Icons.add,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '\$${item.total.toStringAsFixed(0)}',
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            darkCharcoal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
          ),

          const SizedBox(height: 18),

          _summaryRow(
            'Subtotal',
            '\$${azaleaStore.subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 10),

          _summaryRow(
            'Delivery',
            azaleaStore.delivery == 0
                ? 'FREE'
                : '\$${azaleaStore.delivery.toStringAsFixed(2)}',
            valueColor:
                azaleaStore.delivery == 0
                    ? sageGreen
                    : darkCharcoal,
          ),

          const Padding(
            padding:
                EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Divider(
              color: blushPink,
            ),
          ),

          _summaryRow(
            'Total',
            '\$${azaleaStore.total.toStringAsFixed(2)}',
            bold: true,
            valueColor: azaleaPink,
          ),

          if (azaleaStore.subtotal >=
              100) ...[
            const SizedBox(height: 12),
            Container(
              padding:
                  const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(
                color: const Color(
                    0xFFEAF0E8),
                borderRadius:
                    BorderRadius.circular(9),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 17,
                    color: sageGreen,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You received FREE delivery!',
                      style:
                          TextStyle(
                        fontSize: 11,
                        color:
                            darkCharcoal,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(
    String title,
    String value, {
    bool bold = false,
    Color valueColor = darkCharcoal,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: bold ? 16 : 14,
            fontWeight:
                bold ? FontWeight.bold : null,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: bold ? 18 : 14,
            fontWeight:
                bold ? FontWeight.bold : null,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}