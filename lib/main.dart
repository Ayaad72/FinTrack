import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const FinanceHomePage(),
    );
  }
}

class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({super.key});

  @override
  State<FinanceHomePage> createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  final List<Map<String, dynamic>> _transactions = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedCategory = "Food";
  String _selectedType = "Expense";

  // Add transaction
  void _addTransaction() {
    if (_titleController.text.trim().isEmpty || _amountController.text.isEmpty)
      return;

    setState(() {
      _transactions.add({
        "title": _titleController.text.trim(),
        "amount": double.tryParse(_amountController.text) ?? 0,
        "category": _selectedCategory,
        "type": _selectedType,
      });
      _titleController.clear();
      _amountController.clear();
    });

    Navigator.pop(context); // close modal
  }

  // Open input modal
  void _openAddTransactionModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Title (e.g. Coffee)",
                ),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Amount"),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                items: ["Food", "Travel", "Shopping", "Other"]
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              DropdownButton<String>(
                value: _selectedType,
                isExpanded: true,
                items: ["Expense", "Income"]
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedType = val!),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Add Transaction"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Pie chart data
  Map<String, double> getCategoryTotals() {
    final Map<String, double> totals = {
      "Food": 0,
      "Travel": 0,
      "Shopping": 0,
      "Other": 0,
    };
    for (var t in _transactions) {
      if (t["type"] == "Expense") {
        totals[t["category"]] = totals[t["category"]]! + t["amount"];
      }
    }
    return totals;
  }

  @override
  Widget build(BuildContext context) {
    final totals = getCategoryTotals();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "💰 Finance Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Pie Chart Section
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: totals.entries.map((e) {
                  final color = {
                    "Food": Colors.red,
                    "Travel": Colors.blue,
                    "Shopping": Colors.green,
                    "Other": Colors.orange,
                  }[e.key]!;
                  return PieChartSectionData(
                    value: e.value,
                    title: e.value > 0 ? "${e.key}\n\$${e.value}" : "",
                    color: color,
                    radius: 70,
                    titleStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          const Divider(),

          // Transactions List
          Expanded(
            child: _transactions.isEmpty
                ? const Center(child: Text("No transactions yet. Add one! 🚀"))
                : ListView.builder(
                    itemCount: _transactions.length,
                    itemBuilder: (context, index) {
                      final t = _transactions[index];
                      final isIncome = t["type"] == "Income";
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isIncome
                                ? Colors.green
                                : Colors.red,
                            child: Icon(
                              isIncome
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(t["title"]),
                          subtitle: Text("${t["category"]} • ${t["type"]}"),
                          trailing: Text(
                            (isIncome ? "+" : "-") +
                                "\$${t["amount"].toStringAsFixed(2)}",
                            style: TextStyle(
                              color: isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _openAddTransactionModal,
      ),
    );
  }
}
