import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';
import 'orders_screen.dart';

// ============================================================
// CHECKOUT SCREEN
// ============================================================

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 0;

  final List<String> paymentMethods = [
    'Visa ending in 4242',
    'Mastercard ending in 5555',
    'Cash on Delivery',
  ];

  void placeOrder() {
    if (azaleaStore.cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your bag is empty'),
          backgroundColor: azaleaPink,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: const BoxDecoration(
                  color: blushPink,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 55,
                  color: azaleaPink,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Order Placed!',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Thank you for shopping with AZALEA.\n'
                'Your order has been placed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    azaleaStore.cart.clear();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const OrdersScreen(),
                      ),
                      (route) => route.isFirst,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azaleaPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'VIEW MY ORDERS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
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
              'Checkout',
              style: TextStyle(
                color: darkCharcoal,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              10,
              20,
              30,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // ------------------------------------------------
                // DELIVERY ADDRESS
                // ------------------------------------------------

                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.all(10),
                        decoration:
                            const BoxDecoration(
                          color: blushPink,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: azaleaPink,
                          size: 22,
                        ),
                      ),

                      const SizedBox(width: 12),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sophia Laurent',
                              style: TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                color: darkCharcoal,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '123 Flower Street,\n'
                              'Colombo, Sri Lanka',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // PAYMENT METHOD
                // ------------------------------------------------

                const Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: RadioGroup<int>(
                    groupValue: selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        selectedPayment = value!;
                      });
                    },
                    child: Column(
                      children: List.generate(
                        paymentMethods.length,
                        (index) {
                          return RadioListTile<int>(
                            value: index,
                            activeColor: azaleaPink,
                            title: Text(
                              paymentMethods[index],
                              style:
                                  const TextStyle(
                                fontSize: 14,
                                color: darkCharcoal,
                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                            secondary: Icon(
                              index == 0
                                  ? Icons.credit_card
                                  : index == 1
                                      ? Icons.credit_card
                                      : Icons
                                          .payments_outlined,
                              color: azaleaPink,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // ORDER ITEMS
                // ------------------------------------------------

                const Text(
                  'Order Items',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: List.generate(
                      azaleaStore.cart.length,
                      (index) {
                        final item =
                            azaleaStore.cart[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(
                            bottom: 12,
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(
                                        10),
                                child: Image.network(
                                  item.product.imageUrl,
                                  width: 60,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      item.product.title,
                                      maxLines: 2,
                                      overflow:
                                          TextOverflow
                                              .ellipsis,
                                      style:
                                          const TextStyle(
                                        fontSize: 13,
                                        fontWeight:
                                            FontWeight.w600,
                                        color:
                                            darkCharcoal,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: 5),
                                    Text(
                                      'Size: ${item.size} • Qty: ${item.quantity}',
                                      style:
                                          const TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                '\$${item.total.toStringAsFixed(2)}',
                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  color: darkCharcoal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // ORDER SUMMARY
                // ------------------------------------------------

                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _summaryRow(
                        'Subtotal',
                        '\$${azaleaStore.subtotal.toStringAsFixed(2)}',
                      ),

                      const SizedBox(height: 12),

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
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // PLACE ORDER
                // ------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: azaleaPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock_outline,
                          size: 19,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          'PLACE ORDER • \$${azaleaStore.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Center(
                  child: Text(
                    '🔒 Secure checkout',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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