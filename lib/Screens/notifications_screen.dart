import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

class NotificationsScreen extends StatelessWidget {
const NotificationsScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: warmIvory,


  // ============================================================
  // APP BAR
  // ============================================================

  appBar: AppBar(
    backgroundColor: warmIvory,
    elevation: 0,
    centerTitle: true,

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

    title: const Text(
      'Notifications',
      style: TextStyle(
        color: darkCharcoal,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    actions: [
      TextButton(
        onPressed: () {
          // Later we can add "Mark all as read"
        },
        child: const Text(
          'Read all',
          style: TextStyle(
            color: azaleaPink,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  ),

  // ============================================================
  // NOTIFICATION LIST
  // ============================================================

  body: ListView(
    padding: const EdgeInsets.fromLTRB(
      20,
      10,
      20,
      30,
    ),
    children: [
      const Text(
        'Today',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: darkCharcoal,
        ),
      ),

      const SizedBox(height: 12),

      _notificationCard(
        icon: Icons.local_offer_outlined,
        title: 'New arrivals are here ✨',
        message:
            'Discover our latest women\'s fashion collection.',
        time: '10 min ago',
        unread: true,
      ),

      _notificationCard(
        icon: Icons.favorite_border,
        title: 'Something you love is waiting',
        message:
            'Your wishlist has some beautiful pieces waiting for you.',
        time: '1 hour ago',
        unread: true,
      ),

      _notificationCard(
        icon: Icons.local_shipping_outlined,
        title: 'Your order is on the way',
        message:
            'Your latest AZALEA order has been shipped.',
        time: '3 hours ago',
        unread: true,
      ),

      const SizedBox(height: 25),

      const Text(
        'Earlier',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: darkCharcoal,
        ),
      ),

      const SizedBox(height: 12),

      _notificationCard(
        icon: Icons.discount_outlined,
        title: 'Exclusive offer for you',
        message:
            'Enjoy special savings on selected styles.',
        time: 'Yesterday',
        unread: false,
      ),

      _notificationCard(
        icon: Icons.check_circle_outline,
        title: 'Order delivered',
        message:
            'Your AZALEA order was successfully delivered.',
        time: '2 days ago',
        unread: false,
      ),

      _notificationCard(
        icon: Icons.auto_awesome_outlined,
        title: 'Find your perfect style',
        message:
            'Explore our latest looks and create your own style.',
        time: '3 days ago',
        unread: false,
      ),
    ],
  ),
);


}

// ============================================================
// NOTIFICATION CARD
// ============================================================

Widget _notificationCard({
required IconData icon,
required String title,
required String message,
required String time,
required bool unread,
}) {
return Container(
margin: const EdgeInsets.only(bottom: 12),
padding: const EdgeInsets.all(15),


  decoration: BoxDecoration(
    color: unread
        ? blushPink.withValues(alpha: 0.35)
        : Colors.white,
    borderRadius: BorderRadius.circular(17),
    border: Border.all(
      color: inputBorderColor,
    ),
  ),

  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ========================================================
      // ICON
      // ========================================================

      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: unread
              ? azaleaPink.withValues(alpha: 0.15)
              : warmIvory,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: azaleaPink,
          size: 22,
        ),
      ),

      const SizedBox(width: 13),

      // ========================================================
      // TEXT
      // ========================================================

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: darkCharcoal,
                      fontSize: 14,
                      fontWeight: unread
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                ),

                if (unread)
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: azaleaPink,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 5),

            Text(
              message,
              style: const TextStyle(
                color: subtitleColor,
                fontSize: 12,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    ],
  ),
);

}
}
