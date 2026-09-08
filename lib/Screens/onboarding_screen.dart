import 'package:flutter/material.dart';
import '../theme/azalea_colors.dart';
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

