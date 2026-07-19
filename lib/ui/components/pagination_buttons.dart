import 'package:flutter/material.dart';

class LeadPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final bool isLoading;

  const LeadPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPrevious,
    this.onNext,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPrevious = currentPage > 1;
    final bool hasNext = currentPage < totalPages;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffF8FAFC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// Previous Button
          _PaginationButton(
            icon: Icons.arrow_back_ios_new_rounded,
            label: "Previous",
            enabled: hasPrevious && !isLoading,
            onTap: onPrevious,
          ),


          /// Page Indicator
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff2563EB),
              borderRadius: BorderRadius.circular(30),
            ),
            child: isLoading
                ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(
              "$currentPage / $totalPages",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),


          /// Next Button
          _PaginationButton(
            icon: Icons.arrow_forward_ios_rounded,
            label: "Next",
            iconAtEnd: true,
            enabled: hasNext && !isLoading,
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}


class _PaginationButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final bool enabled;
  final bool iconAtEnd;
  final VoidCallback? onTap;


  const _PaginationButton({
    required this.icon,
    required this.label,
    required this.enabled,
    this.iconAtEnd = false,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: enabled ? 1 : .4,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          child: Row(
            children: iconAtEnd
                ? [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 5),
              Icon(icon, size: 16),
            ]
                : [
              Icon(icon, size: 16),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}