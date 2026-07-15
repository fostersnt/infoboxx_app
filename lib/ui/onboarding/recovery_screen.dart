import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  // Exact color palette matching the brand and reference design
  static const Color primaryYellow = Color(0xFFFBC31B);
  static const Color backgroundPage = Color(0xFFFAF8F5); // Light cream outer background
  static const Color textColorDark = Colors.black;
  static const Color textColorGrey = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPage,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Container(
                // Main white container card matching the reference image layout
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Header Badge (INFO BOXX · PARTNER ONBOARDING) ---
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF9E7), // Very subtle yellow background tint
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: primaryYellow.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "INFO ",
                              style: TextStyle(
                                color: primaryYellow,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const Text(
                              "BOXX",
                              style: TextStyle(
                                color: textColorDark,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "·",
                                style: TextStyle(
                                  color: primaryYellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              "PARTNER ONBOARDING",
                              style: TextStyle(
                                color: primaryYellow,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // --- Title Section ---
                      const Text(
                        "Welcome to partner onboarding",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColorDark,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // --- Subtitle Section ---
                      const Text(
                        "Are you continuing a previous application or starting fresh?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColorGrey,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- Option Card 1: Continue Application (Yellow Tint) ---
                      _buildOptionCard(
                        icon: Icons.assignment_outlined,
                        title: "Continue previous application",
                        subtitle: "Use a draft on this device or enter a recovery code",
                        accentColor: primaryYellow,
                        onTap: () {
                          // Handle resume action
                        },
                      ),

                      const SizedBox(height: 16),

                      // --- Option Card 2: Start Fresh (Slate Grey Tint) ---
                      _buildOptionCard(
                        icon: Icons.refresh_rounded,
                        title: "Start fresh",
                        subtitle: "Begin a new partner application",
                        accentColor: const Color(0xFF90A4AE),
                        onTap: () {
                          // Handle start fresh action
                        },
                      ),

                      const SizedBox(height: 28),

                      // --- Back Button Link at the bottom of the card ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.arrow_back, color: textColorDark, size: 16),
                            label: const Text(
                              "Back to Partners",
                              style: TextStyle(
                                color: textColorDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Card builder helper widget to manage properties and keep things clean
  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final bool isYellow = accentColor == primaryYellow;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isYellow ? primaryYellow.withOpacity(0.5) : const Color(0xFFE2E8F0),
          width: isYellow ? 1.5 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Highlight Icon Block Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: 16),

                // Card Text elements
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: textColorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: textColorGrey,
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Trailing Action Arrow icon
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFFCBD5E1),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}