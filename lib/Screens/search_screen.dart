import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';
import 'product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  List<AzaleaProduct> searchResults = [];

  @override
  void initState() {
    super.initState();

    searchResults = azaleaStore.products;
  }

  void _searchProducts(String query) {
    final text = query.toLowerCase().trim();

    setState(() {
      if (text.isEmpty) {
        searchResults = azaleaStore.products;
      } else {
        searchResults = azaleaStore.products.where((product) {
          return product.title.toLowerCase().contains(text) ||
              product.category.toLowerCase().contains(text);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          'Search',
          style: TextStyle(
            color: darkCharcoal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // SEARCH FIELD
            TextField(
              controller: _searchController,
              onChanged: _searchProducts,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search for clothes, shoes...',
                hintStyle: const TextStyle(
                  color: subtitleColor,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: azaleaPink,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: subtitleColor,
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _searchProducts('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: azaleaPink,
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // RESULTS COUNT
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${searchResults.length} products found',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // PRODUCTS
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 55,
                            color: subtitleColor,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No products found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkCharcoal,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Try another search',
                            style: TextStyle(
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: searchResults.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final product = searchResults[index];

                        return _productCard(product);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productCard(AzaleaProduct product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // DETAILS
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: subtitleColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.price,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: azaleaPink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}