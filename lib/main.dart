import 'package:flutter/material.dart';

void main() {
  runApp(const AzaleaApp());
}

// ============================================================
// AZALEA COLORS
// ============================================================

const Color azaleaPink = Color(0xFFE8899B);
const Color blushPink = Color(0xFFF8DDE2);
const Color warmIvory = Color(0xFFFFF9F5);
const Color sageGreen = Color(0xFFA8B8A0);
const Color darkCharcoal = Color(0xFF3A3032);

// ============================================================
// PRODUCT MODEL
// ============================================================

class AzaleaProduct {
  final String title;
  final String price;
  final String imageUrl;
  final String category;
  final double rating;
  final String? originalPrice;
  final String? discount;
  final String? badge;

  AzaleaProduct({
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    this.originalPrice,
    this.discount,
    this.badge,
  });
}

// ============================================================
// CART ITEM
// ============================================================

class CartItem {
  final AzaleaProduct product;
  String size;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    this.quantity = 1,
  });

  double get numericPrice {
    return double.tryParse(
          product.price.replaceAll('\$', '').replaceAll(',', ''),
        ) ??
        0;
  }

  double get total {
    return numericPrice * quantity;
  }
}

// ============================================================
// AZALEA STORE
// ============================================================

class AzaleaStore extends ChangeNotifier {
  final List<AzaleaProduct> products = [
    AzaleaProduct(
      title: 'Sage Green Midi Dress',
      price: '\$189',
      category: 'Dresses',
      rating: 4.8,
      badge: 'NEW',
      originalPrice: '\$249',
      discount: '24% OFF',
      imageUrl:
          'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=700',
    ),
    AzaleaProduct(
      title: 'Azalea Pink Blouse',
      price: '\$124',
      category: 'Tops',
      rating: 4.6,
      imageUrl:
          'https://images.unsplash.com/photo-1564257577054-7c0d8f4a0f87?w=700',
    ),
    AzaleaProduct(
      title: 'Ivory Satin Dress',
      price: '\$215',
      category: 'Dresses',
      rating: 4.9,
      badge: 'SALE',
      originalPrice: '\$285',
      discount: '25% OFF',
      imageUrl:
          'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=700',
    ),
    AzaleaProduct(
      title: 'Classic Beige Trousers',
      price: '\$98',
      category: 'Bottoms',
      rating: 4.5,
      imageUrl:
          'https://images.unsplash.com/photo-1594633312681-425c7b97ccd1?w=700',
    ),
    AzaleaProduct(
      title: 'Soft Pink Cardigan',
      price: '\$145',
      category: 'Tops',
      rating: 4.7,
      badge: 'NEW',
      imageUrl:
          'https://images.unsplash.com/photo-1434389677669-e08b4cac3105?w=700',
    ),
    AzaleaProduct(
      title: 'Minimal White Sneakers',
      price: '\$167',
      category: 'Shoes',
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=700',
    ),
    AzaleaProduct(
      title: 'Blush Pleated Skirt',
      price: '\$112',
      category: 'Bottoms',
      rating: 4.8,
      imageUrl:
          'https://images.unsplash.com/photo-1583496661160-fb5886a13d27?w=700',
    ),
    AzaleaProduct(
      title: 'Sage Green Handbag',
      price: '\$245',
      category: 'Accessories',
      rating: 4.9,
      imageUrl:
          'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=700',
    ),
  ];

  final Set<String> wishlist = {};

  final List<CartItem> cart = [];

  bool isWishlisted(AzaleaProduct product) {
    return wishlist.contains(product.title);
  }

  void toggleWishlist(AzaleaProduct product) {
    if (wishlist.contains(product.title)) {
      wishlist.remove(product.title);
    } else {
      wishlist.add(product.title);
    }

    notifyListeners();
  }

  void addToCart(
    AzaleaProduct product, {
    String size = 'M',
    int quantity = 1,
  }) {
    final existingIndex = cart.indexWhere(
      (item) =>
          item.product.title == product.title && item.size == size,
    );

    if (existingIndex != -1) {
      cart[existingIndex].quantity += quantity;
    } else {
      cart.add(
        CartItem(
          product: product,
          size: size,
          quantity: quantity,
        ),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cart.length) {
      cart[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cart.length) {
      if (cart[index].quantity > 1) {
        cart[index].quantity--;
      } else {
        cart.removeAt(index);
      }

      notifyListeners();
    }
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < cart.length) {
      cart.removeAt(index);
      notifyListeners();
    }
  }

  int get cartCount {
    int count = 0;

    for (final item in cart) {
      count += item.quantity;
    }

    return count;
  }

  double get subtotal {
    double total = 0;

    for (final item in cart) {
      total += item.total;
    }

    return total;
  }

  double get delivery {
    if (cart.isEmpty) {
      return 0;
    }

    return subtotal >= 100 ? 0 : 8;
  }

  double get total {
    return subtotal + delivery;
  }
}

// Global store
final AzaleaStore azaleaStore = AzaleaStore();

// ============================================================
// AZALEA APP
// ============================================================

class AzaleaApp extends StatelessWidget {
  const AzaleaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AZALEA',
      theme: ThemeData(
        scaffoldBackgroundColor: warmIvory,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: azaleaPink,
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

// ============================================================
// ONBOARDING
// ============================================================

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      imageUrl:
          'https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=900',
      title: 'Discover New Collections',
      description:
          'Explore the latest fashion pieces curated just for your unique style.',
    ),
    OnboardingData(
      imageUrl:
          'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=900',
      title: 'Express Your Style',
      description:
          'Find beautiful pieces that help you express who you truly are.',
    ),
    OnboardingData(
      imageUrl:
          'https://images.unsplash.com/photo-1445205170230-053b83016050?w=900',
      title: 'Your Style, Your Story',
      description:
          'Create your perfect wardrobe and make every outfit part of your story.',
    ),
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: pages[index],
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? azaleaPink
                          : blushPink,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 25),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azaleaPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    currentPage == pages.length - 1
                        ? 'GET STARTED'
                        : 'NEXT',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ONBOARDING DATA
// ============================================================

class OnboardingData {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingData({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

// ============================================================
// ONBOARDING PAGE
// ============================================================

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          const SizedBox(height: 20),

          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(28),
              child: Image.network(
                data.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            data.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

// ============================================================
// WELCOME / LOGIN
// ============================================================

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() =>
      _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),

              Center(
                child: Column(
                  children: [
                    const Text(
                      'AZALEA',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5,
                        color: azaleaPink,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'YOUR STYLE, YOUR STORY',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 2,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Sign in to continue your fashion journey.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 35),

              TextField(
                controller: emailController,
                keyboardType:
                    TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                      const Icon(Icons.email_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon:
                      const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: azaleaPink,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: azaleaPink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// SIGN UP
// ============================================================

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: darkCharcoal,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: darkCharcoal,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Join AZALEA and discover your style.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 35),

            _inputField(
              'Full Name',
              Icons.person_outline,
            ),

            const SizedBox(height: 16),

            _inputField(
              'Email',
              Icons.email_outlined,
            ),

            const SizedBox(height: 16),

            _inputField(
              'Password',
              Icons.lock_outline,
              obscure: true,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: azaleaPink,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'CREATE ACCOUNT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

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

// ============================================================
// COUNT BADGE
// ============================================================

Widget _countBadge(int count) {
  return Container(
    padding: const EdgeInsets.all(4),
    constraints: const BoxConstraints(
      minWidth: 17,
      minHeight: 17,
    ),
    decoration: const BoxDecoration(
      color: azaleaPink,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// ============================================================
// HOME CONTENT
// ============================================================

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() =>
      _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> categories = [
    'All',
    'Dresses',
    'Tops',
    'Bottoms',
    'Shoes',
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning, Sophia ✨',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Find your style',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: darkCharcoal,
                      ),
                    ),
                  ],
                ),
              ),

              Stack(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(10),
                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none,
                      color: darkCharcoal,
                    ),
                  ),
                  Positioned(
                    right: 9,
                    top: 8,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration:
                          const BoxDecoration(
                        color: azaleaPink,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // SEARCH
          _searchBox(
            'Search for clothes, shoes...',
          ),

          const SizedBox(height: 25),

          // HERO
          ClipRRect(
            borderRadius:
                BorderRadius.circular(22),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1485230895905-ec40ba36b9bc?w=1000',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  Container(
                    decoration:
                        BoxDecoration(
                      gradient:
                          LinearGradient(
                        begin:
                            Alignment.centerLeft,
                        end:
                            Alignment.centerRight,
                        colors: [
                          Colors.black
                              .withOpacity(0.65),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'NEW ARRIVALS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Summer Collection\n2026',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 14),
                        Text(
                          'Shop Now  →',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 28),

          _sectionHeader(
            'Categories',
            'View All',
          ),

          const SizedBox(height: 14),

          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection:
                  Axis.horizontal,
              itemCount: categories.length,
              itemBuilder:
                  (context, index) {
                return _categoryChip(
                  categories[index],
                  index ==
                      selectedCategory,
                  () {
                    setState(() {
                      selectedCategory =
                          index;
                    });
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          _sectionHeader(
            'New Arrivals',
            'View All',
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection:
                  Axis.horizontal,
              children: [
                _productCard(
                  context,
                  azaleaStore.products[0],
                ),
                _productCard(
                  context,
                  azaleaStore.products[4],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _sectionHeader(
            'Trending Now',
            'View All',
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection:
                  Axis.horizontal,
              children: [
                _productCard(
                  context,
                  azaleaStore.products[0],
                ),
                _productCard(
                  context,
                  azaleaStore.products[1],
                ),
                _productCard(
                  context,
                  azaleaStore.products[2],
                ),
                _productCard(
                  context,
                  azaleaStore.products[3],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // STYLE STUDIO
          ClipRRect(
            borderRadius:
                BorderRadius.circular(22),
            child: Container(
              height: 180,
              width: double.infinity,
              color: darkCharcoal,
              child: Stack(
                children: [
                  Positioned(
                    right: -30,
                    top: -20,
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?w=500',
                        width: 220,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'STYLE STUDIO',
                          style: TextStyle(
                            color: blushPink,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create your\nperfect look',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Explore Style Studio →',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          _sectionHeader(
            'Recommended For You',
            'View All',
          ),

          const SizedBox(height: 15),

          SizedBox(
            height: 310,
            child: ListView(
              scrollDirection:
                  Axis.horizontal,
              children: [
                _productCard(
                  context,
                  azaleaStore.products[4],
                ),
                _productCard(
                  context,
                  azaleaStore.products[5],
                ),
                _productCard(
                  context,
                  azaleaStore.products[6],
                ),
                _productCard(
                  context,
                  azaleaStore.products[7],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Widget _productCard(
    BuildContext context,
    AzaleaProduct product,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin:
            const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    height: 230,
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                if (product.badge != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            product.badge ==
                                    'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                      child: Text(
                        product.badge!,
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: _favoriteButton(
                    product,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              product.title,
              maxLines: 1,
              overflow:
                  TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight:
                    FontWeight.w600,
                color: darkCharcoal,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                    color: darkCharcoal,
                  ),
                ),
                if (product.originalPrice !=
                    null) ...[
                  const SizedBox(width: 6),
                  Text(
                    product.originalPrice!,
                    style:
                        const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration:
                          TextDecoration
                              .lineThrough,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: azaleaPink,
                ),
                const SizedBox(width: 3),
                Text(
                  product.rating
                      .toString(),
                  style:
                      const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _favoriteButton(
    AzaleaProduct product,
  ) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final liked =
            azaleaStore.isWishlisted(product);

        return Container(
          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              azaleaStore
                  .toggleWishlist(product);
            },
            icon: Icon(
              liked
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 19,
              color: liked
                  ? azaleaPink
                  : darkCharcoal,
            ),
          ),
        );
      },
    );
  }

  Widget _categoryChip(
    String title,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            const EdgeInsets.only(right: 10),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        decoration: BoxDecoration(
          color: selected
              ? azaleaPink
              : Colors.white,
          borderRadius:
              BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : darkCharcoal,
              fontWeight:
                  FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(
    String title,
    String action,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight:
                FontWeight.bold,
            color: darkCharcoal,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 13,
            color: azaleaPink,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// SEARCH BOX
// ============================================================

Widget _searchBox(String hint) {
  return Container(
    height: 52,
    padding:
        const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        const SizedBox(width: 10),
        Text(
          hint,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// EXPLORE SCREEN
// ============================================================

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() =>
      _ExploreScreenState();
}

class _ExploreScreenState
    extends State<ExploreScreen> {
  int selectedCategory = 0;

  final List<String> categories = [
    'All',
    'Dresses',
    'Tops',
    'Bottoms',
    'Shoes',
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final selectedName =
            categories[selectedCategory];

        final filteredProducts =
            selectedName == 'All'
                ? azaleaStore.products
                : azaleaStore.products
                    .where(
                      (product) =>
                          product.category ==
                          selectedName,
                    )
                    .toList();

        return SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find something you love',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              _searchBox(
                'Search products...',
              ),

              const SizedBox(height: 25),

              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight:
                      FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection:
                      Axis.horizontal,
                  itemCount:
                      categories.length,
                  itemBuilder:
                      (context, index) {
                    final selected =
                        selectedCategory ==
                            index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              index;
                        });
                      },
                      child: Container(
                        margin:
                            const EdgeInsets
                                .only(
                          right: 10,
                        ),
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 18,
                        ),
                        decoration:
                            BoxDecoration(
                          color: selected
                              ? azaleaPink
                              : Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(22),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style:
                                TextStyle(
                              color: selected
                                  ? Colors.white
                                  : darkCharcoal,
                              fontWeight:
                                  FontWeight
                                      .w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Text(
                    selectedName == 'All'
                        ? 'All Products'
                        : selectedName,
                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      color: darkCharcoal,
                    ),
                  ),
                  Text(
                    '${filteredProducts.length} items',
                    style:
                        const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount:
                    filteredProducts.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 18,
                  childAspectRatio: 0.58,
                ),
                itemBuilder:
                    (context, index) {
                  return _exploreProductCard(
                    context,
                    filteredProducts[index],
                  );
                },
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }

  Widget _exploreProductCard(
    BuildContext context,
    AzaleaProduct product,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                if (product.badge != null)
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            product.badge ==
                                    'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                      child: Text(
                        product.badge!,
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 7,
                  right: 7,
                  child: AnimatedBuilder(
                    animation: azaleaStore,
                    builder:
                        (context, child) {
                      final liked =
                          azaleaStore
                              .isWishlisted(
                                  product);

                      return Container(
                        decoration:
                            BoxDecoration(
                          color: Colors.white
                              .withOpacity(
                                  0.9),
                          shape:
                              BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            azaleaStore
                                .toggleWishlist(
                                    product);
                          },
                          icon: Icon(
                            liked
                                ? Icons.favorite
                                : Icons
                                    .favorite_border,
                            size: 18,
                            color: liked
                                ? azaleaPink
                                : darkCharcoal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          Text(
            product.title,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                product.price,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                      FontWeight.bold,
                  color: darkCharcoal,
                ),
              ),
              if (product.originalPrice !=
                  null) ...[
                const SizedBox(width: 5),
                Text(
                  product.originalPrice!,
                  style:
                      const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration:
                        TextDecoration
                            .lineThrough,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 3),

          Row(
            children: [
              const Icon(
                Icons.star,
                size: 14,
                color: azaleaPink,
              ),
              const SizedBox(width: 3),
              Text(
                product.rating
                    .toString(),
                style:
                    const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// WISHLIST SCREEN
// ============================================================

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final wishlistProducts =
            azaleaStore.products
                .where(
                  (product) =>
                      azaleaStore
                          .isWishlisted(
                              product),
                )
                .toList();

        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            25,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Your favorite pieces',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets
                            .all(11),
                    decoration:
                        BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius
                              .circular(13),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: azaleaPink,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              if (wishlistProducts.isEmpty)
                _emptyWishlist()
              else
                GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount:
                      wishlistProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.63,
                  ),
                  itemBuilder:
                      (context, index) {
                    final product =
                        wishlistProducts[
                            index];

                    return _wishlistCard(
                      context,
                      product,
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _emptyWishlist() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 120),
      child: Center(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(24),
              decoration:
                  const BoxDecoration(
                color: blushPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 48,
                color: azaleaPink,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Wishlist is Empty',
              style: TextStyle(
                fontSize: 23,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Save your favorite fashion pieces\nand find them here anytime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wishlistCard(
    BuildContext context,
    AzaleaProduct product,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration:
                        const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        azaleaStore
                            .toggleWishlist(
                                product);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: azaleaPink,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                if (product.badge != null)
                  Positioned(
                    top: 9,
                    left: 9,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            product.badge ==
                                    'SALE'
                                ? sageGreen
                                : azaleaPink,
                        borderRadius:
                            BorderRadius.circular(
                                18),
                      ),
                      child: Text(
                        product.badge!,
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 9),

          Text(
            product.title,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight:
                  FontWeight.w600,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            product.price,
            style: const TextStyle(
              fontSize: 15,
              fontWeight:
                  FontWeight.bold,
              color: darkCharcoal,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CART SCREEN
// ============================================================

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        return SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            30,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Your Bag',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Review your selected items',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (azaleaStore.cartCount >
                      0)
                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration:
                          BoxDecoration(
                        color: blushPink,
                        borderRadius:
                            BorderRadius
                                .circular(20),
                      ),
                      child: Text(
                        '${azaleaStore.cartCount} items',
                        style:
                            const TextStyle(
                          color: azaleaPink,
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 25),

              if (azaleaStore.cart.isEmpty)
                _emptyCart()
              else ...[
                ...List.generate(
                  azaleaStore.cart.length,
                  (index) {
                    return _cartItem(
                      context,
                      index,
                      azaleaStore.cart[index],
                    );
                  },
                ),

                const SizedBox(height: 25),

                _orderSummary(),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Checkout feature coming soon ✨',
                          ),
                          backgroundColor:
                              azaleaPink,
                          behavior:
                              SnackBarBehavior
                                  .floating,
                        ),
                      );
                    },
                    style: ElevatedButton
                        .styleFrom(
                      backgroundColor:
                          azaleaPink,
                      foregroundColor:
                          Colors.white,
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius
                                .circular(15),
                      ),
                    ),
                    child: const Text(
                      'PROCEED TO CHECKOUT',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _emptyCart() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 120),
      child: Center(
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.all(24),
              decoration:
                  const BoxDecoration(
                color: blushPink,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: azaleaPink,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Your Bag is Empty',
              style: TextStyle(
                fontSize: 23,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add something beautiful to your bag\nand it will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItem(
    BuildContext context,
    int index,
    CartItem item,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(13),
            child: Image.network(
              item.product.imageUrl,
              width: 95,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style:
                            const TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w600,
                          color:
                              darkCharcoal,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        azaleaStore
                            .removeFromCart(
                                index);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  item.product.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                    color: azaleaPink,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration:
                      BoxDecoration(
                    color: blushPink,
                    borderRadius:
                        BorderRadius.circular(
                            7),
                  ),
                  child: Text(
                    'Size: ${item.size}',
                    style:
                        const TextStyle(
                      fontSize: 11,
                      color: darkCharcoal,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                  children: [
                    Container(
                      height: 38,
                      decoration:
                          BoxDecoration(
                        color: warmIvory,
                        borderRadius:
                            BorderRadius
                                .circular(10),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding:
                                EdgeInsets.zero,
                            onPressed: () {
                              azaleaStore
                                  .decreaseQuantity(
                                      index);
                            },
                            icon:
                                const Icon(
                              Icons.remove,
                              size: 17,
                            ),
                          ),
                          Text(
                            item.quantity
                                .toString(),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                          IconButton(
                            padding:
                                EdgeInsets.zero,
                            onPressed: () {
                              azaleaStore
                                  .increaseQuantity(
                                      index);
                            },
                            icon:
                                const Icon(
                              Icons.add,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '\$${item.total.toStringAsFixed(0)}',
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            darkCharcoal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(17),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
                color: darkCharcoal,
              ),
            ),
          ),

          const SizedBox(height: 18),

          _summaryRow(
            'Subtotal',
            '\$${azaleaStore.subtotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 10),

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

          if (azaleaStore.subtotal >=
              100) ...[
            const SizedBox(height: 12),
            Container(
              padding:
                  const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(
                color: const Color(
                    0xFFEAF0E8),
                borderRadius:
                    BorderRadius.circular(9),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    size: 17,
                    color: sageGreen,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'You received FREE delivery!',
                      style:
                          TextStyle(
                        fontSize: 11,
                        color:
                            darkCharcoal,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
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

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        30,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'My Profile',
            style: TextStyle(
              fontSize: 28,
              fontWeight:
                  FontWeight.bold,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 20),

          // PROFILE HEADER
          Container(
            padding:
                const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 15),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Sophia Anderson',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'sophia@example.com',
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                      const EdgeInsets.all(9),
                  decoration:
                      const BoxDecoration(
                    color: blushPink,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: azaleaPink,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'My Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 12),

          _profileTile(
            icon: Icons.receipt_long_outlined,
            title: 'My Orders',
            subtitle:
                'View your order history',
          ),

          _profileTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            subtitle:
                'Manage delivery addresses',
          ),

          _profileTile(
            icon: Icons.credit_card_outlined,
            title: 'Payment Methods',
            subtitle:
                'Manage your payment options',
          ),

          const SizedBox(height: 20),

          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
              color: darkCharcoal,
            ),
          ),

          const SizedBox(height: 12),

          _profileTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle:
                'Manage notifications',
          ),

          _profileTile(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle:
                'App and account settings',
          ),

          _profileTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle:
                'Get help with AZALEA',
          ),

          const SizedBox(height: 20),

          _profileTile(
            icon: Icons.logout,
            title: 'Logout',
            subtitle:
                'Sign out of your account',
            iconColor: azaleaPink,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const WelcomeScreen(),
                ),
                (route) => false,
              );
            },
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              'AZALEA • YOUR STYLE, YOUR STORY',
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.5,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color iconColor = darkCharcoal,
    VoidCallback? onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        leading: Container(
          padding:
              const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor ==
                    azaleaPink
                ? blushPink
                : warmIvory,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
                FontWeight.w600,
            color: darkCharcoal,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}

// ============================================================
// PRODUCT DETAILS
// ============================================================

class ProductDetailsScreen
    extends StatefulWidget {
  final AzaleaProduct product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState
    extends State<ProductDetailsScreen> {
  String selectedSize = 'M';
  int quantity = 1;

  void addToBag() {
    azaleaStore.addToCart(
      widget.product,
      size: selectedSize,
      quantity: quantity,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '${widget.product.title} added to bag',
        ),
        backgroundColor: azaleaPink,
        behavior:
            SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: azaleaStore,
      builder: (context, child) {
        final liked =
            azaleaStore.isWishlisted(
                widget.product);

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
              'Product Details',
              style: TextStyle(
                color: darkCharcoal,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  azaleaStore
                      .toggleWishlist(
                          widget.product);
                },
                icon: Icon(
                  liked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: liked
                      ? azaleaPink
                      : darkCharcoal,
                ),
              ),
            ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.only(
                        bottomLeft:
                            Radius.circular(30),
                        bottomRight:
                            Radius.circular(30),
                      ),
                      child: Image.network(
                        widget.product.imageUrl,
                        height: 430,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    if (widget.product
                            .badge !=
                        null)
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                widget.product
                                            .badge ==
                                        'SALE'
                                    ? sageGreen
                                    : azaleaPink,
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        20),
                          ),
                          child: Text(
                            widget.product
                                .badge!,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            const TextStyle(
                          fontSize: 25,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: azaleaPink,
                            size: 20,
                          ),
                          const SizedBox(
                              width: 5),
                          Text(
                            widget.product
                                .rating
                                .toString(),
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                          const SizedBox(
                              width: 8),
                          const Text(
                            '(128 reviews)',
                            style:
                                TextStyle(
                              color:
                                  Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 18),

                      Row(
                        children: [
                          Text(
                            widget.product
                                .price,
                            style:
                                const TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  azaleaPink,
                            ),
                          ),

                          if (widget.product
                                  .originalPrice !=
                              null) ...[
                            const SizedBox(
                                width: 10),
                            Text(
                              widget.product
                                  .originalPrice!,
                              style:
                                  const TextStyle(
                                fontSize: 15,
                                color:
                                    Colors.grey,
                                decoration:
                                    TextDecoration
                                        .lineThrough,
                              ),
                            ),
                          ],

                          if (widget.product
                                  .discount !=
                              null) ...[
                            const SizedBox(
                                width: 10),
                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration:
                                  BoxDecoration(
                                color:
                                    blushPink,
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            8),
                              ),
                              child: Text(
                                widget.product
                                    .discount!,
                                style:
                                    const TextStyle(
                                  color:
                                      azaleaPink,
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(
                          height: 28),

                      const Text(
                        'Description',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      const Text(
                        'A beautiful and elegant piece designed '
                        'for effortless everyday style. Made with '
                        'high-quality materials for a comfortable '
                        'and luxurious feel. Perfect for creating '
                        'a sophisticated and timeless look.',
                        style:
                            TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 28),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        children: [
                          const Text(
                            'Select Size',
                            style:
                                TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight
                                      .bold,
                              color:
                                  darkCharcoal,
                            ),
                          ),
                          const Text(
                            'Size Guide',
                            style:
                                TextStyle(
                              color:
                                  azaleaPink,
                              fontSize: 13,
                              fontWeight:
                                  FontWeight
                                      .w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 14),

                      Row(
                        children: [
                          _sizeButton('S'),
                          _sizeButton('M'),
                          _sizeButton('L'),
                          _sizeButton('XL'),
                        ],
                      ),

                      const SizedBox(
                          height: 28),

                      const Text(
                        'Quantity',
                        style:
                            TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              darkCharcoal,
                        ),
                      ),

                      const SizedBox(
                          height: 12),

                      Container(
                        width: 145,
                        height: 48,
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      12),
                          border:
                              Border.all(
                            color:
                                blushPink,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (quantity >
                                    1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                              icon:
                                  const Icon(
                                Icons.remove,
                                size: 19,
                              ),
                            ),

                            Text(
                              quantity
                                  .toString(),
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                                fontSize: 16,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon:
                                  const Icon(
                                Icons.add,
                                size: 19,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 56,
                        child:
                            ElevatedButton(
                          onPressed:
                              addToBag,
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                                azaleaPink,
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          15),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              Icon(
                                Icons
                                    .shopping_bag_outlined,
                                size: 20,
                              ),
                              SizedBox(
                                  width: 10),
                              Text(
                                'ADD TO BAG',
                                style:
                                    TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                  letterSpacing:
                                      1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                          height: 18),

                      Container(
                        padding:
                            const EdgeInsets
                                .all(15),
                        decoration:
                            BoxDecoration(
                          color:
                              blushPink,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                        ),
                        child:
                            const Row(
                          children: [
                            Icon(
                              Icons
                                  .local_shipping_outlined,
                              color:
                                  azaleaPink,
                            ),
                            SizedBox(
                                width: 12),
                            Expanded(
                              child:
                                  Text(
                                'Free delivery on orders over \$100',
                                style:
                                    TextStyle(
                                  color:
                                      darkCharcoal,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 15),

                      Container(
                        padding:
                            const EdgeInsets
                                .all(15),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                        ),
                        child:
                            const Row(
                          children: [
                            Icon(
                              Icons
                                  .verified_outlined,
                              color:
                                  sageGreen,
                            ),
                            SizedBox(
                                width: 12),
                            Expanded(
                              child:
                                  Text(
                                'Authentic products with quality guarantee',
                                style:
                                    TextStyle(
                                  color:
                                      darkCharcoal,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                          height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sizeButton(String size) {
    final bool selected =
        selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        width: 55,
        height: 45,
        margin:
            const EdgeInsets.only(
          right: 12,
        ),
        decoration: BoxDecoration(
          color: selected
              ? azaleaPink
              : Colors.white,
          borderRadius:
              BorderRadius.circular(10),
          border: Border.all(
            color: selected
                ? azaleaPink
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : darkCharcoal,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}