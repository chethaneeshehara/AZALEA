import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import '../models/product.dart';


// ============================================================
// STYLE STUDIO SCREEN
// ============================================================

class StyleStudioScreen extends StatefulWidget {
  const StyleStudioScreen({super.key});

  @override
  State<StyleStudioScreen> createState() => _StyleStudioScreenState();
}

class _StyleStudioScreenState extends State<StyleStudioScreen> {
  final Map<String, AzaleaProduct?> selectedItems = {
    'Top': null,
    'Bottom': null,
    'Shoes': null,
    'Accessories': null,
  };

  String selectedCategory = 'Top';

  List<AzaleaProduct> get categoryProducts {
    return azaleaStore.products.where((product) {
      return product.category.toLowerCase() ==
          selectedCategory.toLowerCase();
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,

      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Style Studio',
          style: TextStyle(
            color: darkCharcoal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: darkCharcoal,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: [
          // ----------------------------------------------------
          // INTRO
          // ----------------------------------------------------

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: blushPink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Text(
                  '✨',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Your Look',
                        style: TextStyle(
                          color: darkCharcoal,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mix and match your favorite pieces to create your perfect outfit.',
                        style: TextStyle(
                          color: subtitleColor,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ----------------------------------------------------
          // SELECTED OUTFIT
          // ----------------------------------------------------

          const Text(
            'Your Outfit',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _outfitItem(
                  'Top',
                  selectedItems['Top'],
                  Icons.checkroom_outlined,
                ),

                _outfitDivider(),

                _outfitItem(
                  'Bottom',
                  selectedItems['Bottom'],
                  Icons.shopping_bag_outlined,
                ),

                _outfitDivider(),

                _outfitItem(
                  'Shoes',
                  selectedItems['Shoes'],
                  Icons.hiking_outlined,
                ),

                _outfitDivider(),

                _outfitItem(
                  'Accessories',
                  selectedItems['Accessories'],
                  Icons.watch_outlined,
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ----------------------------------------------------
          // CATEGORY SELECTOR
          // ----------------------------------------------------

          const Text(
            'Choose Items',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryButton('Top'),
                const SizedBox(width: 8),
                _categoryButton('Bottom'),
                const SizedBox(width: 8),
                _categoryButton('Shoes'),
                const SizedBox(width: 8),
                _categoryButton('Accessories'),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ----------------------------------------------------
          // PRODUCT LIST
          // ----------------------------------------------------

          if (categoryProducts.isEmpty)
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.checkroom_outlined,
                    size: 40,
                    color: subtitleColor,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No items available',
                    style: TextStyle(
                      color: darkCharcoal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          else
            SizedBox(
              height: 225,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categoryProducts.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 14);
                },
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];

                  return _productCard(product);
                },
              ),
            ),

          const SizedBox(height: 25),

          // ----------------------------------------------------
          // CREATE LOOK BUTTON
          // ----------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                _createLook();
              },
              icon: const Icon(
                Icons.auto_awesome,
                size: 19,
              ),
              label: const Text(
                'Create My Look',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: azaleaPink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ----------------------------------------------------
          // CLEAR BUTTON
          // ----------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  selectedItems.updateAll(
                    (key, value) => null,
                  );
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your outfit has been cleared.',
                    ),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: azaleaPink,
                side: BorderSide(
                  color: azaleaPink.withValues(alpha: 0.4),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Clear Outfit',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY BUTTON
  // ============================================================

  Widget _categoryButton(String category) {
    final bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected ? azaleaPink : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? azaleaPink
                : inputBorderColor,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : darkCharcoal,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT CARD
  // ============================================================

  Widget _productCard(AzaleaProduct product) {
    final bool isSelected =
        selectedItems[selectedCategory] == product;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItems[selectedCategory] = product;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${product.title} added to your outfit.',
            ),
          ),
        );
      },
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? azaleaPink
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              child: Image.network(
                product.imageUrl,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (
                  context,
                  error,
                  stackTrace,
                ) {
                  return Container(
                    height: 140,
                    color: blushPink,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: azaleaPink,
                        size: 35,
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: darkCharcoal,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    product.price,
                    style: const TextStyle(
                      color: darkCharcoal,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
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

  // ============================================================
  // OUTFIT ITEM
  // ============================================================

  Widget _outfitItem(
    String category,
    AzaleaProduct? product,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: blushPink,
              borderRadius: BorderRadius.circular(12),
            ),
            child: product == null
                ? Icon(
                    icon,
                    color: azaleaPink,
                    size: 22,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Icon(
                          icon,
                          color: azaleaPink,
                          size: 22,
                        );
                      },
                    ),
                  ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: subtitleColor,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  product?.title ?? 'Choose an item',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: product == null
                        ? subtitleColor
                        : darkCharcoal,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            product == null
                ? Icons.add_circle_outline
                : Icons.check_circle,
            color: product == null
                ? subtitleColor
                : sageGreen,
            size: 21,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // OUTFIT DIVIDER
  // ============================================================

  Widget _outfitDivider() {
    return const Divider(
      height: 1,
      indent: 62,
      endIndent: 5,
      color: Color(0xFFF7EFEB),
    );
  }

  // ============================================================
  // CREATE LOOK
  // ============================================================

  void _createLook() {
    final selectedCount = selectedItems.values
        .where((product) => product != null)
        .length;

    if (selectedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Choose some items to create your look.',
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Your Look is Ready ✨',
            style: TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            selectedCount == 4
                ? 'Perfect! You have created a complete outfit with top, bottom, shoes and accessories.'
                : 'Great choice! You have selected $selectedCount item${selectedCount == 1 ? '' : 's'} for your look.',
            style: const TextStyle(
              color: subtitleColor,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: azaleaPink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}