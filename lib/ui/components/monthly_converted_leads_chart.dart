import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:infoboxx/util/app_colors.dart';

class MonthlyConvertedLeadsChart extends StatefulWidget {
  // Map of Month Name -> Converted Count (e.g. {"Jan": 4, "Feb": 12, ...})
  final Map<String, int> monthlyData;

  const MonthlyConvertedLeadsChart({
    super.key,
    required this.monthlyData,
  });

  @override
  State<MonthlyConvertedLeadsChart> createState() =>
      _MonthlyConvertedLeadsChartState();
}

class _MonthlyConvertedLeadsChartState
    extends State<MonthlyConvertedLeadsChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final months = widget.monthlyData.keys.toList();
    final counts = widget.monthlyData.values.toList();

    // Find highest count to scale the Y-axis properly
    final maxCount = counts.isEmpty
        ? 10
        : counts.reduce((a, b) => a > b ? a : b).toDouble();
    final maxY = maxCount == 0 ? 10.0 : (maxCount * 1.25);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.blackGunMetal, // Dark charcoal tile
        // color: const Color(0xFF1E1E1E), // Dark charcoal tile
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFBC31B).withOpacity(0.15),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBC31B).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bar_chart_rounded,
                      color: Color(0xFFFBC31B),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Converted Leads",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Monthly Performance Overview",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Total Sum Pill
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "${counts.fold(0, (sum, val) => sum + val)} total",
                  style: const TextStyle(
                    color: Color(0xFFFBC31B),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // Chart Canvas
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                maxY: maxY,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => const Color(0xFF2C2C2C),
                    tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    tooltipMargin: 8,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        "${months[group.x.toInt()]}\n",
                        const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "${rod.toY.toInt()} Converted",
                            style: const TextStyle(
                              color: Color(0xFFFBC31B),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (value, meta) {
                        if (value % 5 != 0 && value != 0) {
                          return const SizedBox.shrink();
                        }
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.35),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= months.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            months[index],
                            style: TextStyle(
                              color: touchedIndex == index
                                  ? const Color(0xFFFBC31B)
                                  : Colors.white.withOpacity(0.5),
                              fontSize: 11,
                              fontWeight: touchedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: (maxY / 4).clamp(1, 100),
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.05),
                    strokeWidth: 1,
                  ),
                ),
                barGroups: List.generate(months.length, (index) {
                  final isTouched = index == touchedIndex;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: counts[index].toDouble(),
                        gradient: LinearGradient(
                          colors: isTouched
                              ? [
                            const Color(0xFFFFF099),
                            const Color(0xFFFBC31B)
                          ]
                              : [
                            const Color(0xFFFBC31B),
                            const Color(0xFFFBC31B).withOpacity(0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        width: isTouched ? 18 : 14,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: maxY,
                          color: Colors.white.withOpacity(0.03),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}