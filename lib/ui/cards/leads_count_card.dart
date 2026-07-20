import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class AnimatedLeadCountCard extends StatefulWidget {
  final int totalLeads;
  final String title;
  final double percentageChange; // e.g., 12.5 for +12.5%
  final VoidCallback? onTap;

  const AnimatedLeadCountCard({
    super.key,
    required this.totalLeads,
    this.title = "Total Leads",
    this.percentageChange = 12.5,
    this.onTap,
  });

  @override
  State<AnimatedLeadCountCard> createState() => _AnimatedLeadCountCardState();
}

class _AnimatedLeadCountCardState extends State<AnimatedLeadCountCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Initialize directly at the passed initial value
    _countAnimation = IntTween(
      begin: widget.totalLeads,
      end: widget.totalLeads,
    ).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedLeadCountCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalLeads != widget.totalLeads) {
      _countAnimation = IntTween(
        begin: oldWidget.totalLeads,
        end: widget.totalLeads,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPositive = widget.percentageChange >= 0;
    final badgeColor = isPositive ? const Color(0xFF4CAF50) : const Color(0xFFE57373);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.whitePure, // Dark background container
          // color: const Color(0xFF1E1E1E), // Dark background container
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.yellowAmber.withOpacity(0.4),
            width: 1,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: AppColors.grayCoolSlate,
          //     blurRadius: 10,
          //     offset: const Offset(0, 8),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Title & Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBC31B).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.people_alt_rounded,
                        color: Color(0xFFFBC31B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: AppColors.blackCharcoal,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Trend Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badgeColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: badgeColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${isPositive ? '+' : ''}${widget.percentageChange.toStringAsFixed(1)}%",
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Number Counter Display
            AnimatedBuilder(
              animation: _countAnimation,
              builder: (context, child) {
                return Text(
                  _countAnimation.value.toString(),
                  style: TextStyle(
                    color: AppColors.blackCharcoal,
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                );
              },
            ),

            const SizedBox(height: 4),

            // Subtitle
            Text(
              "Active opportunities in pipeline",
              style: TextStyle(
                color: AppColors.blackCharcoal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}