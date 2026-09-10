import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

// ============================================================
// PAYMENT METHODS SCREEN
// ============================================================

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() =>
      _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState
    extends State<PaymentMethodsScreen> {
  final List<Map<String, String>> cards = [
    {
      'type': 'Visa',
      'last4': '4242',
      'holder': 'Sophia Laurent',
      'expiry': '12/28',
    },
    {
      'type': 'Mastercard',
      'last4': '5555',
      'holder': 'Sophia Laurent',
      'expiry': '08/27',
    },
  ];

  void _showCardForm({int? index}) {
    final existing = index != null ? cards[index] : null;

    final holderController =
        TextEditingController(text: existing?['holder'] ?? '');
    final numberController =
        TextEditingController(text: existing?['last4'] ?? '');
    final expiryController =
        TextEditingController(text: existing?['expiry'] ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: warmIvory,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  index == null
                      ? 'Add Payment Card'
                      : 'Edit Payment Card',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),

                const SizedBox(height: 20),

                _inputField(
                  controller: holderController,
                  label: 'Cardholder Name',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 12),

                _inputField(
                  controller: numberController,
                  label: 'Last 4 Digits',
                  icon: Icons.credit_card_outlined,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                ),

                const SizedBox(height: 12),

                _inputField(
                  controller: expiryController,
                  label: 'Expiry Date (MM/YY)',
                  icon: Icons.calendar_month_outlined,
                  keyboardType: TextInputType.datetime,
                ),

                const SizedBox(height: 10),

                const Text(
                  'Demo only — do not enter real card details.',
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (holderController.text.trim().isEmpty ||
                          numberController.text.trim().length != 4 ||
                          expiryController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please enter valid demo card details.',
                            ),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        final cardType =
                            index != null
                                ? cards[index]['type']!
                                : 'Visa';

                        final newCard = {
                          'type': cardType,
                          'last4':
                              numberController.text.trim(),
                          'holder':
                              holderController.text.trim(),
                          'expiry':
                              expiryController.text.trim(),
                        };

                        if (index == null) {
                          cards.add(newCard);
                        } else {
                          cards[index] = newCard;
                        }
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: azaleaPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      index == null
                          ? 'Save Card'
                          : 'Update Card',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        prefixIcon: Icon(
          icon,
          color: azaleaPink,
          size: 20,
        ),
        labelStyle: const TextStyle(
          color: subtitleColor,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: inputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: azaleaPink,
            width: 1.5,
          ),
        ),
      ),
    );
  }

  void _deleteCard(int index) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Remove Card',
            style: TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to remove this card?',
            style: TextStyle(
              color: subtitleColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: darkCharcoal,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cards.removeAt(index);
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: azaleaPink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
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
          'Payment Methods',
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
          const Text(
            'Saved Cards',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          ...List.generate(
            cards.length,
            (index) {
              final card = cards[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      darkCharcoal,
                      Color(0xFF5A4A4D),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.credit_card,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          card['type']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Text(
                      '••••  ••••  ••••  ${card['last4']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'CARD HOLDER',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 8,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              card['holder']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'EXPIRES',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 8,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              card['expiry']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showCardForm(index: index);
                          },
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        GestureDetector(
                          onTap: () {
                            _deleteCard(index);
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 5),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                _showCardForm();
              },
              icon: const Icon(
                Icons.add,
                color: azaleaPink,
              ),
              label: const Text(
                'Add New Card',
                style: TextStyle(
                  color: azaleaPink,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: azaleaPink,
                  width: 1.2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }
}