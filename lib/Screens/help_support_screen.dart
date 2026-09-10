import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

// ============================================================
// HELP & SUPPORT SCREEN
// ============================================================

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,

      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Help & Support',
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
          // SUPPORT INTRO
          // ----------------------------------------------------

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: blushPink,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.support_agent_outlined,
                    color: azaleaPink,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 15),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How can we help?',
                        style: TextStyle(
                          color: darkCharcoal,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Find answers or get in touch with our support team.',
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
          // QUICK HELP
          // ----------------------------------------------------

          const Text(
            'Quick Help',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Container(
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
                _helpTile(
                  icon: Icons.help_outline,
                  title: 'Frequently Asked Questions',
                  subtitle: 'Find answers to common questions',
                  onTap: () {
                    _showFaqDialog(context);
                  },
                ),

                _divider(),

                _helpTile(
                  icon: Icons.inventory_2_outlined,
                  title: 'Order Help',
                  subtitle: 'Questions about your orders',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Order Help',
                      'For order-related questions, please check '
                          'your My Orders section first. You can view '
                          'your order status and details there.',
                    );
                  },
                ),

                _divider(),

                _helpTile(
                  icon: Icons.credit_card_outlined,
                  title: 'Payment Help',
                  subtitle: 'Problems with payments or cards',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Payment Help',
                      'If you have a payment issue, please check '
                          'your saved payment method and try again. '
                          'For further assistance, contact our support team.',
                    );
                  },
                ),

                _divider(),

                _helpTile(
                  icon: Icons.lock_outline,
                  title: 'Account & Security',
                  subtitle: 'Manage account and security questions',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Account & Security',
                      'Keep your account information secure and '
                          'avoid sharing your password with anyone. '
                          'For security concerns, please contact support.',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ----------------------------------------------------
          // CONTACT US
          // ----------------------------------------------------

          const Text(
            'Contact Us',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Container(
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
                _helpTile(
                  icon: Icons.email_outlined,
                  title: 'Email Support',
                  subtitle: 'support@azalea.com',
                  onTap: () {
                    _showContactDialog(
                      context,
                      'Email Support',
                      'support@azalea.com',
                    );
                  },
                ),

                _divider(),

                _helpTile(
                  icon: Icons.chat_bubble_outline,
                  title: 'Live Chat',
                  subtitle: 'Chat with our support team',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Live Chat',
                      'Live Chat is currently available as a demo. '
                          'In the full version, you will be able to '
                          'chat directly with an AZALEA support agent.',
                    );
                  },
                ),

                _divider(),

                _helpTile(
                  icon: Icons.access_time,
                  title: 'Support Hours',
                  subtitle: 'Monday - Friday • 9:00 AM - 6:00 PM',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Support Hours',
                      'Our support team is available Monday to Friday '
                          'from 9:00 AM to 6:00 PM.',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ----------------------------------------------------
          // SEND MESSAGE BUTTON
          // ----------------------------------------------------

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                _showMessageDialog(context);
              },
              icon: const Icon(
                Icons.send_outlined,
                size: 19,
              ),
              label: const Text(
                'Send Us a Message',
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

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // HELP TILE
  // ============================================================

  Widget _helpTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 5,
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: blushPink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: azaleaPink,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: darkCharcoal,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          subtitle,
          style: const TextStyle(
            color: subtitleColor,
            fontSize: 11,
          ),
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 18,
        color: Color(0xFFA09093),
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  Widget _divider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 18,
      endIndent: 18,
      color: Color(0xFFF7EFEB),
    );
  }

  // ============================================================
  // FAQ DIALOG
  // ============================================================

  void _showFaqDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _FaqItem(
                  question: 'How can I place an order?',
                  answer:
                      'Browse your favorite products, open the product '
                      'details, select your size and add the item to your cart.',
                ),
                SizedBox(height: 16),
                _FaqItem(
                  question: 'Can I save products for later?',
                  answer:
                      'Yes. Tap the heart icon on a product to add it '
                      'to your Wishlist.',
                ),
                SizedBox(height: 16),
                _FaqItem(
                  question: 'How can I check my orders?',
                  answer:
                      'Open your Profile and select My Orders to view '
                      'your previous orders and their status.',
                ),
                SizedBox(height: 16),
                _FaqItem(
                  question: 'How can I update my address?',
                  answer:
                      'Go to Profile → Address Book to add, edit or '
                      'remove your saved addresses.',
                ),
              ],
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

  // ============================================================
  // INFO DIALOG
  // ============================================================

  void _showInfoDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
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

  // ============================================================
  // CONTACT DIALOG
  // ============================================================

  void _showContactDialog(
    BuildContext context,
    String title,
    String email,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You can contact our support team at:',
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: const TextStyle(
                  color: azaleaPink,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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

  // ============================================================
  // SEND MESSAGE DIALOG
  // ============================================================

  void _showMessageDialog(BuildContext context) {
    final TextEditingController messageController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Send Us a Message',
            style: TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write your message...',
              hintStyle: const TextStyle(
                color: subtitleColor,
                fontSize: 13,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: inputBorderColor,
                ),
              ),
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
                ),
              ),
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
                if (messageController.text.trim().isEmpty) {
                  return;
                }

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Your message has been sent successfully.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: azaleaPink,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}

// ============================================================
// FAQ ITEM
// ============================================================

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(
            color: darkCharcoal,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          answer,
          style: const TextStyle(
            color: subtitleColor,
            fontSize: 12,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}