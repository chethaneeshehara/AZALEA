
import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';

import 'product_details_screen.dart';
import 'search_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

// ============================================================
// HOME CONTENT
// ============================================================

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> categories = [
    'All',
    'Dresses',
    'Tops',
    'Bottoms',
    'Shoes',
    'Accessories'
  ];

  int selectedCategory = 0;

  // ============================================================
  // FILTER PRODUCTS BY CATEGORY
  // ============================================================

  List<AzaleaProduct> get filteredProducts {
    if (selectedCategory == 0) {
      return azaleaStore.products;
    }

    final selectedName = categories[selectedCategory];

    return azaleaStore.products.where((product) {
      return product.category.toLowerCase() ==
          selectedName.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isCategorySelected = selectedCategory != 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // HEADER
          // ============================================================

          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Sophia ✨',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Find your style',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: darkCharcoal,
                      ),
                    ),
                  ],
                ),
              ),

              // NOTIFICATION
              GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      ),
    );
  },
  child: Stack(
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.notifications_none,
          color: darkCharcoal,
        ),
      ),

      Positioned(
        right: 9,
        top: 8,
        child: Container(
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            color: azaleaPink,
            shape: BoxShape.circle,
          ),
        ),
      ),
    ],
  ),
),

              const SizedBox(width: 10),

                            // PROFILE IMAGE
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ProfileScreen(),
                    ),
                  );
                },
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
                    width: 45,
                    height: 45,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(width: 10),
            ],
          ),

          const SizedBox(height: 22),

          // ============================================================
          // SEARCH
          // ============================================================

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: _searchBox(
              'Search for clothes, shoes...',
            ),
          ),

          const SizedBox(height: 25),

          // ============================================================
          // HERO BANNER
          // ============================================================

          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1485230895905-ec40ba36b9bc?w=1000',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withValues(alpha: 0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'NEW ARRIVALS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Summer Collection\n2026',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 14),

                        Text(
                          'Shop Now  →',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          // ============================================================
          // CATEGORIES
          // ============================================================

          _sectionHeader(
            'Categories',
            'View All',
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _categoryChip(
                  categories[index],
                  index == selectedCategory,
                  () {
                    setState(() {
                      selectedCategory = index;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          // ============================================================
          // CATEGORY PRODUCTS
          // ============================================================

          if (isCategorySelected) ...[
            _sectionHeader(
              categories[selectedCategory],
              'View All',
            ),

            const SizedBox(height: 15),

            if (filteredProducts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        size: 55,
                        color: subtitleColor,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'No products available',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: darkCharcoal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return _productCard(
                      context,
                      filteredProducts[index],
                    );
                  },
                ),
              ),

            const SizedBox(height: 30),

            // Show all filtered products in a grid
            _sectionHeader(
              'More ${categories[selectedCategory]}',
              'Explore',
            ),

            const SizedBox(height: 15),

            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount: filteredProducts.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                return _gridProductCard(
                  context,
                  filteredProducts[index],
                );
              },
            ),

            const SizedBox(height: 30),
          ]

          // ============================================================
          // NORMAL HOME CONTENT
          // ============================================================

          else ...[
            // ============================================================
            // NEW ARRIVALS
            // ============================================================

            _sectionHeader(
              'New Arrivals',
              'View All',
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 310,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _productCard(
                    context,
                    azaleaStore.products[0],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[4],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ============================================================
            // TRENDING NOW
            // ============================================================

            _sectionHeader(
              'Trending Now',
              'View All',
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 310,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _productCard(
                    context,
                    azaleaStore.products[0],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[1],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[2],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[3],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ============================================================
            // STYLE STUDIO
            // ============================================================

            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                height: 180,
                width: double.infinity,
                color: darkCharcoal,
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -20,
                      child: ClipOval(
                        child: Image.network(
                          'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=500',
                          width: 220,
                          height: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Text(
                            'STYLE STUDIO',
                            style: TextStyle(
                              color: blushPink,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),

                          SizedBox(height: 8),

                          Text(
                            'Create your\nperfect look',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Explore Style Studio →',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ============================================================
            // RECOMMENDED
            // ============================================================

            _sectionHeader(
              'Recommended For You',
              'View All',
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 310,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _productCard(
                    context,
                    azaleaStore.products[4],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[5],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[6],
                  ),
                  _productCard(
                    context,
                    azaleaStore.products[7],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD
  // ============================================================

  Widget _productCard(
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
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    height: 230,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                if (product.badge != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            product.badge == 'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 8,
                  right: 8,
                  child:
                      _favoriteButton(product),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: darkCharcoal,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                if (product.originalPrice != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    product.originalPrice!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration:
                          TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: azaleaPink,
                ),

                const SizedBox(width: 3),

                Text(
                  product.rating.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // GRID PRODUCT CARD
  // ============================================================

  Widget _gridProductCard(
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  if (product.badge != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              product.badge == 'SALE'
                                  ? sageGreen
                                  : azaleaPink,
                          borderRadius:
                              BorderRadius.circular(15),
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
                    top: 6,
                    right: 6,
                    child:
                        _favoriteButton(product),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
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
                      fontSize: 14,
                      fontWeight:
                          FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 13,
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
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FAVORITE BUTTON
  // ============================================================

  Widget _favoriteButton(
    AzaleaProduct product,
  ) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final liked =
            azaleaStore.isWishlisted(product);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.9,
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              azaleaStore.toggleWishlist(product);
            },
            icon: Icon(
              liked
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 19,
              color: liked
                  ? azaleaPink
                  : darkCharcoal,
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // CATEGORY CHIP
  // ============================================================

  Widget _categoryChip(
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            const EdgeInsets.only(right: 10),
        padding:
            const EdgeInsets.symmetric(
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
            title,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : darkCharcoal,
              fontWeight:
                  FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(
    String title,
    String action,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: darkCharcoal,
          ),
        ),

        Text(
          action,
          style: const TextStyle(
            fontSize: 13,
            color: azaleaPink,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SEARCH BOX
// ============================================================

Widget _searchBox(String hint) {
  return Container(
    height: 52,
    padding:
        const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.search,
          color: Colors.grey,
        ),

        const SizedBox(width: 10),

        Text(
          hint,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

