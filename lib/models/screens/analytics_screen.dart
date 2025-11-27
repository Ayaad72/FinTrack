import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  String selectedPeriod = 'Week';

  // Data for different periods
  final Map<String, List<double>> periodData = {
    'Week': [400, 650, 300, 800, 550, 900, 450],
    'Month': [1200, 1500, 1100, 1800, 1400, 2000, 1600, 1300, 1700, 1900, 1500, 1400, 1800, 1600, 1900, 2100, 1700, 1500, 1800, 2000, 1600, 1400, 1900, 1700, 1500, 1800, 2000, 1600, 1800, 1900],
    'Year': [5000, 6000, 5500, 7000, 6500, 8000, 7500, 7000, 8500, 9000, 8500, 9500],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f4ee),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Analytics',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Period Selector
            Row(
              children: [
                _periodChip('Week', selectedPeriod == 'Week'),
                const SizedBox(width: 8),
                _periodChip('Month', selectedPeriod == 'Month'),
                const SizedBox(width: 8),
                _periodChip('Year', selectedPeriod == 'Year'),
              ],
            ),
            const SizedBox(height: 24),

            // Spending Overview
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spending Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: _getMaxY(),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (group) => Colors.deepPurpleAccent,
                            tooltipRoundedRadius: 8,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              return BarTooltipItem(
                                '\$${rod.toY.toStringAsFixed(0)}',
                                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  _getBottomTitle(value.toInt()),
                                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: _getBarGroups(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Category Breakdown
            const Text(
              'Category Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _categoryCard('Food & Dining', '\$1,234', 35, Colors.orange),
            const SizedBox(height: 12),
            _categoryCard('Shopping', '\$890', 25, Colors.blue),
            const SizedBox(height: 12),
            _categoryCard('Transportation', '\$456', 15, Colors.green),
            const SizedBox(height: 12),
            _categoryCard('Entertainment', '\$320', 10, Colors.purple),
            const SizedBox(height: 12),
            _categoryCard('Others', '\$540', 15, Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _periodChip(String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.deepPurpleAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  double _getMaxY() {
    if (selectedPeriod == 'Week') return 1000;
    if (selectedPeriod == 'Month') return 2500;
    return 10000;
  }

  String _getBottomTitle(int index) {
    if (selectedPeriod == 'Week') {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return index < days.length ? days[index] : '';
    } else if (selectedPeriod == 'Month') {
      return '${index + 1}';
    } else {
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return index < months.length ? months[index] : '';
    }
  }

  List<BarChartGroupData> _getBarGroups() {
    final data = periodData[selectedPeriod]!;
    return List.generate(
      data.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: Colors.deepPurpleAccent,
            width: selectedPeriod == 'Month' ? 8 : 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(String name, String amount, int percentage, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.category, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
