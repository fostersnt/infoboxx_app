import 'package:flutter/material.dart';

class EmptyLeadsView extends StatelessWidget {
  final VoidCallback? onRefresh;

  const EmptyLeadsView({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon in a subtle circular glow background
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFBC31B).withOpacity(0.08),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFBC31B).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.person_search_rounded,
                size: 48,
                color: Color(0xFFFBC31B),
              ),
            ),
            const SizedBox(height: 24),
            // Primary Heading
            const Text(
              "No Leads Found",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle Description
            Text(
              "You don't have any active enquiries or outreach right now. Check back later or create a new lead.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14,
                height: 1.4,
              ),
            ),
            if (onRefresh != null) ...[
              const SizedBox(height: 24),
              // Action Button
              OutlinedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text("Refresh"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFBC31B),
                  side: BorderSide(
                    color: const Color(0xFFFBC31B).withOpacity(0.5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}