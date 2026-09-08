import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';
import '../store/app_store.dart';

import 'explore_screen.dart';
import 'wishlist_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
// ============================================================
// HOME SCREEN + BOTTOM NAVIGATION
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedBottomNav = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: warmIvory,

          body: SafeArea(
            child: _getSelectedPage(),
          ),

          bottomNavigationBar:
              BottomNavigationBar(
            currentIndex: selectedBottomNav,
            onTap: (index) {
              setState(() {
                selectedBottomNav = index;
              });
            },
            type:
                BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: azaleaPink,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle:
                const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon:
                    Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                    Icons.favorite_border),
                activeIcon: const Icon(
                    Icons.favorite),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                    ),
                    if (azaleaStore.cartCount > 0)
                      Positioned(
                        right: -7,
                        top: -7,
                        child: _countBadge(
                          azaleaStore.cartCount,
                        ),
                      ),
                  ],
                ),
                activeIcon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                    ),
                    if (azaleaStore.cartCount > 0)
                      Positioned(
                        right: -7,
                        top: -7,
                        child: _countBadge(
                          azaleaStore.cartCount,
                        ),
                      ),
                  ],
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon:
                    Icon(Icons.person_outline),
                activeIcon:
                    Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getSelectedPage() {
    switch (selectedBottomNav) {
      case 1:
        return const ExploreScreen();
      case 2:
        return const WishlistScreen();
      case 3:
        return const CartScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const HomeContent();
    }
  }
}
