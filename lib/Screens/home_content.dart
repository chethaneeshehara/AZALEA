import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';

import 'product_details_screen.dart';
import 'search_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'style_studio_screen.dart';

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
    'Accessories',
  ];

  int selectedCategory = 0;

  // ============================================================
  // CATEGORY ICONS
  // ============================================================

  final Map<String, IconData> categoryIcons = {
  'All': Icons.grid_view_rounded,
  'Dresses': Icons.checkroom_outlined,
  'Tops': Icons.shopping_bag_outlined,
  'Bottoms': Icons.style_outlined,
  'Shoes': Icons.shopping_bag_outlined,
  'Accessories': Icons.watch_outlined,
};

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

  // ============================================================
  // VIEW ALL CATEGORY
  // ============================================================

  void viewAllCategory(String category) {
    final index = categories.indexOf(category);

    if (index != -1) {
      setState(() {
        selectedCategory = index;
      });
    }
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

              // ------------------------------------------------
              // NOTIFICATION
              // ------------------------------------------------

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const NotificationsScreen(),
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

              // ------------------------------------------------
              // PROFILE IMAGE
              // ------------------------------------------------

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

          GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = 0;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Explore our latest summer collection ✨',
                  ),
                  backgroundColor: azaleaPink,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: ClipRRect(
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
                            Colors.black.withValues(
                              alpha: 0.70,
                            ),
                            Colors.black.withValues(
                              alpha: 0.08,
                            ),
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
                              height: 1.15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 15),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Shop Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 17,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.90,
                          ),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Explore',
                          style: TextStyle(
                            color: darkCharcoal,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ============================================================
          // CATEGORIES
          // ============================================================

          _sectionHeader(
            'Categories',
            'View All',
            onTap: () {
              setState(() {
                selectedCategory = 0;
              });
            },
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 82,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _categoryItem(
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
              onTap: () {},
            ),

            const SizedBox(height: 15),

            if (filteredProducts.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 50,
                ),
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
                height: 330,
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

            _sectionHeader(
              'More ${categories[selectedCategory]}',
              'Explore',
              onTap: () {},
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
              onTap: () {
                setState(() {
                  selectedCategory = 0;
                });
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 330,
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

            const SizedBox(height: 28),

            // ============================================================
            // TRENDING NOW
            // ============================================================

            _sectionHeader(
              'Trending Now',
              'View All',
              onTap: () {
                setState(() {
                  selectedCategory = 0;
                });
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 330,
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

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const StyleStudioScreen(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  height: 185,
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

                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                darkCharcoal,
                                darkCharcoal.withValues(
                                  alpha: 0.15,
                                ),
                              ],
                            ),
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
                                fontWeight:
                                    FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              'Create your\nperfect look',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                height: 1.15,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 12),

                            Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore Style Studio',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white70,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
              onTap: () {
                setState(() {
                  selectedCategory = 0;
                });
              },
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 330,
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.07,
                        ),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(17),
                    child: Image.network(
                      product.imageUrl,
                      height: 230,
                      width: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // BADGE
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
                        color: product.badge == 'SALE'
                            ? sageGreen
                            : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        product.badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),

                // DISCOUNT
                if (product.discount != null)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: darkCharcoal.withValues(
                          alpha: 0.82,
                        ),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: Text(
                        product.discount!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                // FAVORITE
                Positioned(
                  top: 8,
                  right: 8,
                  child:
                      _favoriteButton(product),
                ),
              ],
            ),

            const SizedBox(height: 11),

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
                      fontSize: 11,
                      color: Colors.grey,
                      decoration:
                          TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 5),

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
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(width: 4),

                const Text(
                  '•',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(width: 4),

                const Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 10,
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
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.05,
              ),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
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
                          color: product.badge == 'SALE'
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

                  if (product.discount != null)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: darkCharcoal.withValues(
                            alpha: 0.82,
                          ),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Text(
                          product.discount!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
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

                      if (product.originalPrice != null)
                        const SizedBox(width: 5),

                      if (product.originalPrice != null)
                        Flexible(
                          child: Text(
                            product.originalPrice!,
                            overflow:
                                TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              decoration:
                                  TextDecoration
                                      .lineThrough,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

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
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.92,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.08,
                ),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              azaleaStore.toggleWishlist(product);

              ScaffoldMessenger.of(context)
                  .hideCurrentSnackBar();

              ScaffoldMessenger.of(context)
                  .showSnackBar(
                SnackBar(
                  content: Text(
                    liked
                        ? 'Removed from wishlist'
                        : 'Added to wishlist ❤️',
                  ),
                  backgroundColor: azaleaPink,
                  duration:
                      const Duration(seconds: 1),
                ),
              );
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
  // CATEGORY ITEM
  // ============================================================

  Widget _categoryItem(
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200),
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: selected
                    ? azaleaPink
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? azaleaPink
                      : inputBorderColor,
                  width: 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color:
                              azaleaPink.withValues(
                            alpha: 0.25,
                          ),
                          blurRadius: 12,
                          offset:
                              const Offset(0, 5),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color:
                              Colors.black.withValues(
                            alpha: 0.03,
                          ),
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2),
                        ),
                      ],
              ),
              child: Icon(
                categoryIcons[title] ??
                    Icons.category_outlined,
                color: selected
                    ? Colors.white
                    : darkCharcoal,
                size: 23,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              title,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: selected
                    ? azaleaPink
                    : subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(
    String title,
    String action, {
    VoidCallback? onTap,
  }) {
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

        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                action,
                style: const TextStyle(
                  fontSize: 13,
                  color: azaleaPink,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.arrow_forward_ios,
                size: 11,
                color: azaleaPink,
              ),
            ],
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
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(
            alpha: 0.04,
          ),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        const Icon(
          Icons.search,
          color: Colors.grey,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            hint,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: blushPink,
            borderRadius:
                BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.tune_rounded,
            color: azaleaPink,
            size: 18,
          ),
        ),
      ],
    ),
  );
}