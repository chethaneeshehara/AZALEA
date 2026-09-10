import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

import 'welcome_screen.dart';
import 'wishlist_screen.dart';
import 'notifications_screen.dart';

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ------------------------------------------------
              // Centered Profile Avatar
              // ------------------------------------------------

              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: azaleaPink.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 42,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ------------------------------------------------
              // User Name & Email
              // ------------------------------------------------

              const Text(
                'Sophia Laurent',
                style: TextStyle(
                  fontFamily: 'serif',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                'sophia@example.com',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8A7A7D),
                ),
              ),

              const SizedBox(height: 20),

              // ------------------------------------------------
              // User Stats Row
              // ------------------------------------------------

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _statItem(
                    '12',
                    'Orders',
                    darkCharcoal,
                  ),
                  _statDivider(),
                  _statItem(
                    '5',
                    'Outfits',
                    darkCharcoal,
                  ),
                  _statDivider(),
                  _statItem(
                    '23',
                    'Saved',
                    darkCharcoal,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Main Menu Grouped Card
              // ------------------------------------------------

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
                    // MY ORDERS
                    _menuTile(
                      emoji: '📦',
                      title: 'My Orders',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'My Orders will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // WISHLIST
                    _menuTile(
                      emoji: '❤️',
                      title: 'Wishlist',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const WishlistScreen(),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // ADDRESS BOOK
                    _menuTile(
                      emoji: '📍',
                      title: 'Address Book',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Address Book will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // PAYMENT METHODS
                    _menuTile(
                      emoji: '💳',
                      title: 'Payment Methods',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Payment Methods will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // NOTIFICATIONS
                    _menuTile(
                      emoji: '🔔',
                      title: 'Notifications',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationsScreen(),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // STYLE STUDIO
                    _menuTile(
                      emoji: '✨',
                      title: 'Style Studio',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Style Studio will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // SETTINGS
                    _menuTile(
                      emoji: '⚙️',
                      title: 'Settings',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Settings will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),

                    _menuDivider(),

                    // HELP & SUPPORT
                    _menuTile(
                      emoji: '💬',
                      title: 'Help & Support',
                      isLast: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Help & Support will be available soon.',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // ------------------------------------------------
              // Sign Out Button
              // ------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          backgroundColor: warmIvory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: const Text(
                            'Sign Out',
                            style: TextStyle(
                              color: darkCharcoal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            'Are you sure you want to sign out?',
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
                                Navigator.pop(dialogContext);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WelcomeScreen(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: azaleaPink,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Sign Out',
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: azaleaPink.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: const Color(0xFFFFF5F6),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: azaleaPink,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STAT ITEM
  // ============================================================

  static Widget _statItem(
    String number,
    String label,
    Color textColor,
  ) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF8A7A7D),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STAT DIVIDER
  // ============================================================

  static Widget _statDivider() {
    return Container(
      height: 20,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      color: const Color(0xFFEFE6E2),
    );
  }

  // ============================================================
  // MENU TILE
  // ============================================================

  static Widget _menuTile({
    required String emoji,
    required String title,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
      leading: Text(
        emoji,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF2C2224),
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
  // MENU DIVIDER
  // ============================================================

  static Widget _menuDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20,
      color: Color(0xFFF7EFEB),
    );
  }
}