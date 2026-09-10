import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';

import 'product_details_screen.dart';
// ============================================================
// WISHLIST SCREEN
// ============================================================

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final wishlistProducts =
            azaleaStore.products
                .where(
                  (product) =>
                      azaleaStore
                          .isWishlisted(
                              product),
                )
                .toList();

        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            25,
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
                        'Wishlist',
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
                        'Your favorite pieces',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets
                            .all(11),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius
                              .circular(13),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: azaleaPink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              if (wishlistProducts.isEmpty)
                _emptyWishlist()
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount:
                      wishlistProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.63,
                  ),
                  itemBuilder:
                      (context, index) {
                    final product =
                        wishlistProducts[
                            index];

                    return _wishlistCard(
                      context,
                      product,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyWishlist() {
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
                Icons.favorite_border,
                size: 48,
                color: azaleaPink,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Wishlist is Empty',
              style: TextStyle(
                fontSize: 23,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Save your favorite fashion pieces\nand find them here anytime.',
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

  Widget _wishlistCard(
    BuildContext context,
    AzaleaProduct product,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        azaleaStore
                            .toggleWishlist(
                                product);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: azaleaPink,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                if (product.badge != null)
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            product.badge ==
                                    'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                      child: Text(
                        product.badge!,
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          Text(
            product.title,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            product.price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.bold,
              color: darkCharcoal,
            ),
          ),
        ],
      ),
    );
  }
}
