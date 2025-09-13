import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ----------------------
// SpendWise — Finance Dashboard
// ----------------------
// Single-file example with nicer UI, sample data, pie chart, add modal,
// summary cards, and transaction list. Frontend-only (no backend).
// ----------------------

void main() {
  runApp(const SpendWiseApp());
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FinanceHomePage(),
    );
  }
}

// ----------------------
// Data model
// ----------------------
class Txn {
  final String id;
  final String title;
  final double amount;
  final String category; // Food, Travel, Shopping, Other
  final bool isIncome;
  final DateTime date;

  Txn({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.isIncome,
    required this.date,
  });
}

// ----------------------
// Constants
// ----------------------
const List<String> kCategories = ["Food", "Travel", "Shopping", "Other"];
const Map<String, Color> kCategoryColors = {
  "Food": Colors.redAccent,
  "Travel": Colors.blueAccent,
  "Shopping": Colors.green,
  "Other": Colors.orangeAccent,
};

// ----------------------
// Main screen
// ----------------------
class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({super.key});

  @override
  State<FinanceHomePage> createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  final List<Txn> _txns = [
    // sample data so the dashboard isn't blank on first run
    Txn(
      id: 't1',
      title: 'Salary',
      amount: 2500,
      category: 'Other',
      isIncome: true,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Txn(
      id: 't2',
      title: 'Groceries',
      amount: 72.50,
      category: 'Food',
      isIncome: false,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Txn(
      id: 't3',
      title: 'Train Ticket',
      amount: 15.0,
      category: 'Travel',
      isIncome: false,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Txn(
      id: 't4',
      title: 'Shoes',
      amount: 120.0,
      category: 'Shopping',
      isIncome: false,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  // controllers for add modal
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = kCategories.first;
  String _selectedType = "Expense";

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // computed totals
  double get totalIncome =>
      _txns.where((t) => t.isIncome).fold(0.0, (s, t) => s + t.amount);

  double get totalExpense =>
      _txns.where((t) => !t.isIncome).fold(0.0, (s, t) => s + t.amount);

  double get balance => totalIncome - totalExpense;

  Map<String, double> getCategoryTotals() {
    final totals = <String, double>{for (var c in kCategories) c: 0.0};
    for (var t in _txns) {
      if (!t.isIncome) {
        totals[t.category] = totals[t.category]! + t.amount;
      }
    }
    return totals;
  }

  // add transaction (with simple validation)
  void _addTransaction() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim() ?? '');
    if (title.isEmpty || amount == null || amount <= 0) {
      // show basic feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid title and amount')),
      );
      return;
    }

    final txn = Txn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      amount: amount,
      category: _selectedCategory,
      isIncome: _selectedType == "Income",
      date: DateTime.now(),
    );

    setState(() {
      _txns.insert(0, txn); // insert at top
    });

    // clear & close modal
    _titleController.clear();
    _amountController.clear();
    _selectedCategory = kCategories.first;
    _selectedType = "Expense";

    Navigator.of(context).pop();
  }

  // open modal bottom sheet
  void _openAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add Transaction',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title (e.g. Coffee)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        items: kCategories
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedCategory = v);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        items: ["Expense", "Income"]
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v == null) return;
                          setState(() => _selectedType = v);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonalIcon(
                        icon: const Icon(Icons.close),
                        label: const Text('Cancel'),
                        onPressed: () {
                          _titleController.clear();
                          _amountController.clear();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(Icons.check),
                        label: const Text('Add'),
                        onPressed: _addTransaction,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteTxn(String id) {
    setState(() {
      _txns.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final totals = getCategoryTotals();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Column(
          children: const [
            Text('FinTrack', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(
              'Personal Budget & Expense Dashboard',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8),
          child: Column(
            children: [
              // khfiytfiytfyt Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Balance',
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${balance.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              SummaryChip(
                                icon: Icons.arrow_downward,
                                color: Colors.greenAccent.shade700,
                                label: 'Income',
                                value: '\$${totalIncome.toStringAsFixed(2)}',
                              ),
                              const SizedBox(width: 8),
                              SummaryChip(
                                icon: Icons.arrow_upward,
                                color: Colors.redAccent.shade200,
                                label: 'Expense',
                                value: '\$${totalExpense.toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // simple circular progress showing expense ratio
                    SizedBox(
                      width: 84,
                      height: 84,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: (totalExpense + totalIncome) == 0
                                ? 0
                                : (totalExpense / (totalExpense + totalIncome)),
                            strokeWidth: 8,
                            color: Colors.white70,
                            backgroundColor: Colors.white24,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${((totalExpense + totalIncome) == 0) ? 0 : ((totalExpense / (totalExpense + totalIncome)) * 100).round()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'spent',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Chart + Legend
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Pie / placeholder
                      Expanded(
                        child: SizedBox(
                          height: 160,
                          child: totals.values.every((v) => v == 0)
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(
                                        Icons.pie_chart_outline,
                                        size: 48,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Text('No expense data yet'),
                                    ],
                                  ),
                                )
                              : PieChart(
                                  PieChartData(
                                    sectionsSpace: 4,
                                    centerSpaceRadius: 28,
                                    sections: totals.entries
                                        .where((e) => e.value > 0)
                                        .map((e) {
                                          final color = kCategoryColors[e.key]!;
                                          return PieChartSectionData(
                                            value: e.value,
                                            color: color,
                                            title: '',
                                            radius: 46,
                                          );
                                        })
                                        .toList(),
                                  ),
                                ),
                        ),
                      ),

                      // Legend
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: totals.entries.map((e) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: kCategoryColors[e.key],
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      e.key,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '\$${e.value.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Transactions header
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Recent Transactions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _openAddModal,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Transaction list
              Expanded(
                child: _txns.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.receipt_long,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No transactions yet',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _txns.length,
                        itemBuilder: (context, i) {
                          final t = _txns[i];
                          return Dismissible(
                            key: ValueKey(t.id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 6,
                              ),
                              padding: const EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) => _deleteTxn(t.id),
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: t.isIncome
                                      ? Colors.green
                                      : kCategoryColors[t.category],
                                  child: Icon(
                                    t.isIncome
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(
                                  t.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '${t.category} • ${_formatDate(t.date)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                trailing: Text(
                                  '${t.isIncome ? "+" : "-"}\$${t.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: t.isIncome
                                        ? Colors.green
                                        : Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddModal,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  String _formatDate(DateTime d) {
    final now = DateTime.now();
    final diff = now.difference(d);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${d.month}/${d.day}/${d.year}';
  }
}

// ----------------------
// Small helper widget
// ----------------------
class SummaryChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const SummaryChip({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color.withOpacity(0.9), fontSize: 12),
          ),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              color: color.withOpacity(0.95),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
