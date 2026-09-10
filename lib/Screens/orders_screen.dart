import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

// ============================================================
// ORDERS SCREEN
// ============================================================

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,

      // --------------------------------------------------------
      // APP BAR
      // --------------------------------------------------------

      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Orders',
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

      // --------------------------------------------------------
      // BODY
      // --------------------------------------------------------

      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        children: [
          // ======================================================
          // ORDER 1
          // ======================================================

          _orderCard(
            context,
            orderNumber: '#AZ1024',
            date: 'September 8, 2026',
            status: 'Delivered',
            statusColor: sageGreen,
            items: 'Sage Green Midi Dress',
            price: '\$189',
            imageUrl:
                'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=500',
          ),

          const SizedBox(height: 16),

          // ======================================================
          // ORDER 2
          // ======================================================

          _orderCard(
            context,
            orderNumber: '#AZ1019',
            date: 'September 5, 2026',
            status: 'Shipped',
            statusColor: azaleaPink,
            items: 'Azalea Pink Blouse',
            price: '\$124',
            imageUrl:
                'https://images.unsplash.com/photo-1564257577054-5c3f4e4e8e7a?w=500',
          ),

          const SizedBox(height: 16),

          // ======================================================
          // ORDER 3
          // ======================================================

          _orderCard(
            context,
            orderNumber: '#AZ1012',
            date: 'August 28, 2026',
            status: 'Delivered',
            statusColor: sageGreen,
            items: 'Ivory Satin Dress',
            price: '\$215',
            imageUrl:
                'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=500',
          ),

          const SizedBox(height: 16),

          // ======================================================
          // ORDER 4
          // ======================================================

          _orderCard(
            context,
            orderNumber: '#AZ1007',
            date: 'August 20, 2026',
            status: 'Delivered',
            statusColor: sageGreen,
            items: 'Classic Beige Trousers',
            price: '\$98',
            imageUrl:
                'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=500',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER CARD
  // ============================================================

  Widget _orderCard(
    BuildContext context, {
    required String orderNumber,
    required String date,
    required String status,
    required Color statusColor,
    required String items,
    required String price,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ------------------------------------------------------
          // ORDER HEADER
          // ------------------------------------------------------

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderNumber,
                style: const TextStyle(
                  color: darkCharcoal,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              date,
              style: const TextStyle(
                color: subtitleColor,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ------------------------------------------------------
          // PRODUCT
          // ------------------------------------------------------

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 75,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Container(
                      width: 75,
                      height: 90,
                      color: blushPink,
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: azaleaPink,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      items,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: darkCharcoal,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      price,
                      style: const TextStyle(
                        color: darkCharcoal,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          const Divider(
            height: 1,
            color: Color(0xFFF1E8E5),
          ),

          const SizedBox(height: 12),

          // ------------------------------------------------------
          // VIEW DETAILS
          // ------------------------------------------------------

          GestureDetector(
            onTap: () {
              _showOrderDetails(
                context,
                orderNumber,
                status,
                date,
                items,
                price,
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'View Order Details',
                  style: TextStyle(
                    color: azaleaPink,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: azaleaPink,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER DETAILS DIALOG
  // ============================================================

  void _showOrderDetails(
    BuildContext context,
    String orderNumber,
    String status,
    String date,
    String item,
    String price,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: warmIvory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),

              const SizedBox(height: 18),

              _detailRow(
                'Order Number',
                orderNumber,
              ),

              _detailRow(
                'Order Date',
                date,
              ),

              _detailRow(
                'Status',
                status,
              ),

              _detailRow(
                'Item',
                item,
              ),

              _detailRow(
                'Total',
                price,
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azaleaPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // DETAIL ROW
  // ============================================================

  Widget _detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              title,
              style: const TextStyle(
                color: subtitleColor,
                fontSize: 12,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: darkCharcoal,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}