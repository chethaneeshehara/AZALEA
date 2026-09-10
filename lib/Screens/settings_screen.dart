
import 'package:flutter/material.dart';

import '../theme/azalea_colors.dart';

// ============================================================
// SETTINGS SCREEN
// ============================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;
  bool emailUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmIvory,

      appBar: AppBar(
        backgroundColor: warmIvory,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Settings',
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
          // ------------------------------------------------
          // PREFERENCES
          // ------------------------------------------------

          const Text(
            'Preferences',
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
                _switchTile(
                  icon: Icons.notifications_none,
                  title: 'Notifications',
                  subtitle: 'Receive updates about your orders',
                  value: notifications,
                  onChanged: (value) {
                    setState(() {
                      notifications = value;
                    });
                  },
                ),

                _divider(),

                _switchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Use a darker appearance',
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value
                              ? 'Dark Mode enabled for demo.'
                              : 'Dark Mode disabled.',
                        ),
                      ),
                    );
                  },
                ),

                _divider(),

                _switchTile(
                  icon: Icons.email_outlined,
                  title: 'Email Updates',
                  subtitle: 'Receive fashion and offer updates',
                  value: emailUpdates,
                  onChanged: (value) {
                    setState(() {
                      emailUpdates = value;
                    });
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ------------------------------------------------
          // ACCOUNT
          // ------------------------------------------------

          const Text(
            'Account',
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
                _actionTile(
                  icon: Icons.lock_outline,
                  title: 'Privacy & Security',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'Privacy & Security',
                      'Your privacy is important to us. '
                          'This demo screen represents where '
                          'privacy and security settings would be managed.',
                    );
                  },
                ),

                _divider(),

                _actionTile(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  trailingText: 'English',
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),

                _divider(),

                _actionTile(
                  icon: Icons.info_outline,
                  title: 'About AZALEA',
                  onTap: () {
                    _showInfoDialog(
                      context,
                      'About AZALEA',
                      'AZALEA is a modern women’s fashion '
                          'e-commerce mobile application designed '
                          'to make discovering and shopping for '
                          'fashion simple and enjoyable.',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          // ------------------------------------------------
          // APP INFORMATION
          // ------------------------------------------------

          const Text(
            'App Information',
            style: TextStyle(
              color: darkCharcoal,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Version',
                  style: TextStyle(
                    color: subtitleColor,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '1.0.0',
                  style: TextStyle(
                    color: darkCharcoal,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // SWITCH TILE
  // ============================================================

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
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
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: subtitleColor,
          fontSize: 11,
        ),
      ),
      trailing: Switch(
        value: value,
        activeThumbColor: azaleaPink,
        onChanged: onChanged,
      ),
    );
  }

  // ============================================================
  // ACTION TILE
  // ============================================================

  Widget _actionTile({
    required IconData icon,
    required String title,
    String? trailingText,
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
      trailing: trailingText != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  trailingText,
                  style: const TextStyle(
                    color: subtitleColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: Color(0xFFA09093),
                ),
              ],
            )
          : const Icon(
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
  // LANGUAGE DIALOG
  // ============================================================

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: warmIvory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Select Language',
            style: TextStyle(
              color: darkCharcoal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(
                dialogContext,
                'English',
              ),
              _languageOption(
                dialogContext,
                'සිංහල',
              ),
              _languageOption(
                dialogContext,
                'தமிழ்',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _languageOption(
    BuildContext dialogContext,
    String language,
  ) {
    return ListTile(
      title: Text(
        language,
        style: const TextStyle(
          color: darkCharcoal,
          fontSize: 14,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xFFA09093),
      ),
      onTap: () {
        Navigator.pop(dialogContext);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '$language selected for demo.',
            ),
          ),
        );
      },
    );
  }
}

