import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class OnboardingSummaryCard extends StatelessWidget {
  final double completionRate; // e.g., 0.85 for 85%
  final String approvalStatus; // e.g., "PENDING", "APPROVED", "REJECTED"
  final int completedSteps;
  final int totalSteps;
  final VoidCallback? onTapContinue;

  const OnboardingSummaryCard({
    super.key,
    required this.completionRate,
    required this.approvalStatus,
    required this.completedSteps,
    required this.totalSteps,
    this.onTapContinue,
  });

  // Helper to get status badge colors
  Color _getStatusColor() {
    switch (approvalStatus.toUpperCase()) {
      case 'APPROVED':
        return const Color(0xFF4CAF50); // Green
      case 'REJECTED':
        return const Color(0xFFE57373); // Red
      case 'PENDING':
      case 'UNDER_REVIEW':
      default:
        return const Color(0xFFFBC31B); // Yellow/Amber
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final percentageInt = (completionRate.clamp(0.0, 1.0) * 100).toInt();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.blackGunMetal.withOpacity(0.7), // Dark background tile
        // color: const Color(0xFF1E1E1E), // Dark background tile
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.whitePure.withOpacity(0.08),
          // color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Title & Approval Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Onboarding Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Service Provider Profile",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: statusColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      approvalStatus.replaceAll('_', ' '),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.08), height: 1),
          const SizedBox(height: 20),

          // Main Section: Radial Progress + Metrics
          Row(
            children: [
              // Radial Ring Indicator
              SizedBox(
                width: 76,
                height: 76,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 76,
                      height: 76,
                      child: CircularProgressIndicator(
                        value: completionRate.clamp(0.0, 1.0),
                        strokeWidth: 7,
                        backgroundColor: Colors.white.withOpacity(0.08),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFBC31B),
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$percentageInt%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Done",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Metrics Grid
              Expanded(
                child: Column(
                  children: [
                    _buildMetricRow(
                      icon: Icons.task_alt_rounded,
                      label: "Steps Completed",
                      value: "$completedSteps of $totalSteps",
                    ),
                    const SizedBox(height: 10),
                    _buildMetricRow(
                      icon: Icons.verified_user_outlined,
                      label: "Verification",
                      value: approvalStatus == "APPROVED" ? "Verified" : "Pending Action",
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bottom Action Button (Conditional)
          if (completionRate < 1.0 && onTapContinue != null) ...[
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton.icon(
                onPressed: onTapContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBC31B),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Text(
                  "Continue Setup",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                label: const Icon(Icons.arrow_forward_rounded, size: 18),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Metric Row Helper
  Widget _buildMetricRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.white.withOpacity(0.5)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}