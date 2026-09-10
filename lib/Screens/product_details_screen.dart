import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';
// ============================================================
// PRODUCT DETAILS
// ============================================================

class ProductDetailsScreen
    extends StatefulWidget {
  final AzaleaProduct product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  String selectedSize = 'M';
  int quantity = 1;

  void addToBag() {
    azaleaStore.addToCart(
      widget.product,
      size: selectedSize,
      quantity: quantity,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.title} added to bag',
        ),
        backgroundColor: azaleaPink,
        behavior:
            SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final liked =
            azaleaStore.isWishlisted(
                widget.product);

        return Scaffold(
          backgroundColor: warmIvory,

          appBar: AppBar(
            backgroundColor: warmIvory,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: darkCharcoal,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Product Details',
              style: TextStyle(
                color: darkCharcoal,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  azaleaStore
                      .toggleWishlist(
                          widget.product);
                },
                icon: Icon(
                  liked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: liked
                      ? azaleaPink
                      : darkCharcoal,
                ),
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(
                        bottomLeft:
                            Radius.circular(30),
                        bottomRight:
                            Radius.circular(30),
                      ),
                      child: Image.network(
                        widget.product.imageUrl,
                        height: 430,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    if (widget.product
                            .badge !=
                        null)
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                widget.product
                                            .badge ==
                                        'SALE'
                                    ? sageGreen
                                    : azaleaPink,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        20),
                          ),
                          child: Text(
                            widget.product
                                .badge!,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            const TextStyle(
                          fontSize: 25,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: azaleaPink,
                            size: 20,
                          ),
                          const SizedBox(
                              width: 5),
                          Text(
                            widget.product
                                .rating
                                .toString(),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                          const SizedBox(
                              width: 8),
                          const Text(
                            '(128 reviews)',
                            style:
                                TextStyle(
                              color:
                                  Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 18),

                      Row(
                        children: [
                          Text(
                            widget.product
                                .price,
                            style:
                                const TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  azaleaPink,
                            ),
                          ),

                          if (widget.product
                                  .originalPrice !=
                              null) ...[
                            const SizedBox(
                                width: 10),
                            Text(
                              widget.product
                                  .originalPrice!,
                              style:
                                  const TextStyle(
                                fontSize: 15,
                                color:
                                    Colors.grey,
                                decoration:
                                    TextDecoration
                                        .lineThrough,
                              ),
                            ),
                          ],

                          if (widget.product
                                  .discount !=
                              null) ...[
                            const SizedBox(
                                width: 10),
                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration:
                                  BoxDecoration(
                                color:
                                    blushPink,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            8),
                              ),
                              child: Text(
                                widget.product
                                    .discount!,
                                style:
                                    const TextStyle(
                                  color:
                                      azaleaPink,
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(
                          height: 28),

                      const Text(
                        'Description',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      const Text(
                        'A beautiful and elegant piece designed '
                        'for effortless everyday style. Made with '
                        'high-quality materials for a comfortable '
                        'and luxurious feel. Perfect for creating '
                        'a sophisticated and timeless look.',
                        style:
                            TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 28),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          const Text(
                            'Select Size',
                            style:
                                TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  darkCharcoal,
                            ),
                          ),
                          const Text(
                            'Size Guide',
                            style:
                                TextStyle(
                              color:
                                  azaleaPink,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 14),

                      Row(
                        children: [
                          _sizeButton('S'),
                          _sizeButton('M'),
                          _sizeButton('L'),
                          _sizeButton('XL'),
                        ],
                      ),

                      const SizedBox(
                          height: 28),

                      const Text(
                        'Quantity',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 12),

                      Container(
                        width: 145,
                        height: 48,
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                          border:
                              Border.all(
                            color:
                                blushPink,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity >
                                    1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon:
                                  const Icon(
                                Icons.remove,
                                size: 19,
                              ),
                            ),

                            Text(
                              quantity
                                  .toString(),
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                                fontSize: 16,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon:
                                  const Icon(
                                Icons.add,
                                size: 19,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 56,
                        child:
                            ElevatedButton(
                          onPressed:
                              addToBag,
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
                                      .circular(
                                          15),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              Icon(
                                Icons
                                    .shopping_bag_outlined,
                                size: 20,
                              ),
                              SizedBox(
                                  width: 10),
                              Text(
                                'ADD TO BAG',
                                style:
                                    TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  letterSpacing:
                                      1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 18),

                      Container(
                        padding:
                            const EdgeInsets
                                .all(15),
                        decoration:
                            BoxDecoration(
                          color:
                              blushPink,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                        ),
                        child:
                            const Row(
                          children: [
                            Icon(
                              Icons
                                  .local_shipping_outlined,
                              color:
                                  azaleaPink,
                            ),
                            SizedBox(
                                width: 12),
                            Expanded(
                              child:
                                  Text(
                                'Free delivery on orders over \$100',
                                style:
                                    TextStyle(
                                  color:
                                      darkCharcoal,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 15),

                      Container(
                        padding:
                            const EdgeInsets
                                .all(15),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                        ),
                        child:
                            const Row(
                          children: [
                            Icon(
                              Icons
                                  .verified_outlined,
                              color:
                                  sageGreen,
                            ),
                            SizedBox(
                                width: 12),
                            Expanded(
                              child:
                                  Text(
                                'Authentic products with quality guarantee',
                                style:
                                    TextStyle(
                                  color:
                                      darkCharcoal,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sizeButton(String size) {
    final bool selected =
        selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        width: 55,
        height: 45,
        margin:
            const EdgeInsets.only(
          right: 12,
        ),
        decoration: BoxDecoration(
          color: selected
              ? azaleaPink
              : Colors.white,
          borderRadius:
              BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? azaleaPink
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : darkCharcoal,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}