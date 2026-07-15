import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({super.key});

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final _codeController = TextEditingController();

  // Exact color palette matching the brand and reference design
  static const Color primaryYellow = Color(0xFFFBC31B);
  static const Color backgroundPage = Color(0xFFFAF8F5); // Light cream outer background
  static const Color textColorDark = Colors.black;
  static const Color textColorGrey = Color(0xFF757575);
  static const Color borderLightGrey = Color(0xFFE2E8F0);

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPage,
      // Prevents layout distortion or pixel clipping when the virtual keyboard slides up
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Container(
                // Main white container box matching the rounded card layout
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
                    crossAxisAlignment: CrossAxisAlignment.start, // Left-aligned content container body
                    children: [
                      // --- Centralized Header Titles ---
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              "Continue your application",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColorDark,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Use a draft saved on this device or enter the recovery code you received when you saved.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: textColorGrey,
                                fontSize: 15,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),

                      // --- Section Label ---
                      const Text(
                        "ENTER RECOVERY CODE",
                        style: TextStyle(
                          color: textColorDark,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // --- Input Context Description ---
                      const Text(
                        "Use the code you received when you saved your draft (e.g. from email or when you clicked \"Save draft\").",
                        style: TextStyle(
                          color: textColorGrey,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Horizontal Row containing Text field and Action button ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left-side Recovery Input Box
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              controller: _codeController,
                              style: const TextStyle(
                                color: textColorDark,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                hintText: "e.g. A1B2-C3D4",
                                hintStyle: const TextStyle(
                                  color: Color(0xFFCBD5E1),
                                  fontSize: 15,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                // Precise border setup matching input styling
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: borderLightGrey),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: borderLightGrey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: primaryYellow, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Right-side Action Load Button
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 50, // Hardcoded matching the exact size scale of input field
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle load draft validation logic
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryYellow,
                                  foregroundColor: textColorDark,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Verify",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // --- Back Button Link at the bottom ---
                      Center(
                        child: TextButton.icon(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back, color: textColorDark, size: 16),
                          label: const Text(
                            "Back to choices",
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
}