import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';

import 'product_details_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Dresses',
    'Tops',
    'Bottoms',
    'Shoes',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final selectedName = categories[selectedCategory];

        final filteredProducts = selectedName == 'All'
            ? azaleaStore.products
            : azaleaStore.products
                .where(
                  (product) =>
                      product.category == selectedName,
                )
                .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find something you love',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _searchBox('Search products...'),

              const SizedBox(height: 25),

              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final selected =
                        selectedCategory == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? azaleaPink
                              : Colors.white,
                          borderRadius:
                              BorderRadius.circular(22),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : darkCharcoal,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedName == 'All'
                        ? 'All Products'
                        : selectedName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),
                  Text(
                    '${filteredProducts.length} items',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: filteredProducts.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) {
                  return _exploreProductCard(
                    context,
                    filteredProducts[index],
                  );
                },
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  Widget _searchBox(String hint) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: inputBorderColor,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: darkCharcoal,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }

  Widget _exploreProductCard(
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

                if (product.badge != null)
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            product.badge == 'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Text(
                        product.badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 7,
                  right: 7,
                  child: AnimatedBuilder(
                    animation: azaleaStore,
                    builder:
                        (context, child) {
                      final liked =
                          azaleaStore
                              .isWishlisted(
                                  product);

                      return Container(
                        decoration:
                            BoxDecoration(
                          color: Colors.white
                              .withValues(
                            alpha: 0.9,
                          ),
                          shape:
                              BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            azaleaStore
                                .toggleWishlist(
                                    product);
                          },
                          icon: Icon(
                            liked
                                ? Icons.favorite
                                : Icons
                                    .favorite_border,
                            size: 18,
                            color: liked
                                ? azaleaPink
                                : darkCharcoal,
                          ),
                        ),
                      );
                    },
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

          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                product.price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),
              if (product.originalPrice !=
                  null) ...[
                const SizedBox(width: 5),
                Text(
                  product.originalPrice!,
                  style:
                      const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration:
                        TextDecoration
                            .lineThrough,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 3),

          Row(
            children: [
              const Icon(
                Icons.star,
                size: 14,
                color: azaleaPink,
              ),
              const SizedBox(width: 3),
              Text(
                product.rating.toString(),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}