import 'package:flutter/material.dart';
import '../theme/azalea_colors.dart';
// ============================================================
// SIGN UP SCREEN
// ============================================================

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isAgreed = false;

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: darkCharcoal,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: inputBorderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(11),
        borderSide: const BorderSide(color: azaleaPink, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back_ios, color: darkCharcoal, size: 20),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 34),

              // Title Section
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.w600,
                  color: darkCharcoal,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Join AZALEA today',
                style: TextStyle(
                  color: subtitleColor,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 25),

              // Full Name
              _buildFieldLabel('Full Name'),
              TextField(
                decoration: _inputDecoration(hintText: 'Sophia Laurent'),
              ),

              const SizedBox(height: 16),

              // Email Address
              _buildFieldLabel('Email Address'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(hintText: 'you@example.com'),
              ),

              const SizedBox(height: 16),

              // Password
              _buildFieldLabel('Password'),
              TextField(
                obscureText: true,
                decoration: _inputDecoration(),
              ),

              const SizedBox(height: 16),

              // Confirm Password
              _buildFieldLabel('Confirm Password'),
              TextField(
                obscureText: true,
                decoration: _inputDecoration(),
              ),

              const SizedBox(height: 20),

              // Terms & Privacy Checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: isAgreed,
                      activeColor: azaleaPink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: inputBorderColor, width: 1.5),
                      onChanged: (val) {
                        setState(() {
                          isAgreed = val ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 12, color: subtitleColor, height: 1.4),
                        children: [
                          TextSpan(text: "I agree to AZALEA's "),
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(color: azaleaPink),
                          ),
                          TextSpan(text: " and "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: azaleaPink),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isAgreed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please agree to the Terms of Service and Privacy Policy.',
                          ),
                          backgroundColor: azaleaPink,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
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
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Bottom Link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: subtitleColor, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: azaleaPink,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}