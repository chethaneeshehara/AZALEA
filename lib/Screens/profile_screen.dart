import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

import 'welcome_screen.dart';

// ============================================================
// PROFILE SCREEN (MATCHING DESIGN SPECIFICATION)
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              // User Stats Row (Orders / Outfits / Saved)
              // ------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _statItem('12', 'Orders', darkCharcoal),
                  _statDivider(),
                  _statItem('5', 'Outfits', darkCharcoal),
                  _statDivider(),
                  _statItem('23', 'Saved', darkCharcoal),
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
                    _menuTile(emoji: '📦', title: 'My Orders'),
                    _menuDivider(),
                    _menuTile(emoji: '❤️', title: 'Wishlist'),
                    _menuDivider(),
                    _menuTile(emoji: '📍', title: 'Address Book'),
                    _menuDivider(),
                    _menuTile(emoji: '💳', title: 'Payment Methods'),
                    _menuDivider(),
                    _menuTile(emoji: '🔔', title: 'Notifications'),
                    _menuDivider(),
                    _menuTile(emoji: '✨', title: 'Style Studio'),
                    _menuDivider(),
                    _menuTile(emoji: '⚙️', title: 'Settings'),
                    _menuDivider(),
                    _menuTile(emoji: '💬', title: 'Help & Support', isLast: true),
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                      (route) => false,
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

  // Helper Widget: Individual Stat Column
  static Widget _statItem(String number, String label, Color textColor) {
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

  // Helper Widget: Divider between stats
  static Widget _statDivider() {
    return Container(
      height: 20,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      color: const Color(0xFFEFE6E2),
    );
  }

  // Helper Widget: Menu Item Row
  static Widget _menuTile({
    required String emoji,
    required String title,
    VoidCallback? onTap,
    bool isLast = false,
  }) {
    return ListTile(
      onTap: onTap ?? () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      leading: Text(
        emoji,
        style: const TextStyle(fontSize: 18),
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

  // Helper Widget: Thin separator line for menu list
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
