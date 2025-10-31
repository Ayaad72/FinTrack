import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/local_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// hey i ddddddddddddddcccc a Comment
class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': '1',
      'title': 'Salary',
      'amount': 2500.0,
      'category': 'Income',
      'type': 'Income',
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '2',
      'title': 'Groceries',
      'amount': 80.5,
      'category': 'Food',
      'type': 'Expense',
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  String _selectedCategory = 'Food';
  String _selectedType = 'Expense';

  final List<String> _categories = [
    'Food',
    'Travel',
    'Shopping',
    'Health',
    'Other',
  ];

  String name = "";
  String email = "";
  String dob = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await LocalStorage.getUserData();
    setState(() {
      name = user['name'] ?? 'User';
      email = user['email'] ?? 'example@mail.com';
    });
  }

  double get totalIncome => _transactions
      .where((t) => t['type'] == 'Income')
      .fold(0.0, (sum, t) => sum + t['amount']);

  double get totalExpense => _transactions
      .where((t) => t['type'] == 'Expense')
      .fold(0.0, (sum, t) => sum + t['amount']);

  double get totalBalance => totalIncome - totalExpense;

  void _addTransaction() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    if (title.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter valid data')));
      return;
    }

    setState(() {
      _transactions.insert(0, {
        'id': DateTime.now().toString(),
        'title': title,
        'amount': amount,
        'category': _selectedCategory,
        'type': _selectedType,
        'date': DateTime.now(),
      });
    });

    _titleController.clear();
    _amountController.clear();
    Navigator.pop(context);
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((t) => t['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Transaction deleted'),
        backgroundColor: Colors.redAccent,
        duration: Duration(milliseconds: 900),
      ),
    );
  }

  void _openProfileDialog() {
    final TextEditingController nameController = TextEditingController(
      text: name,
    );
    final TextEditingController emailController = TextEditingController(
      text: email,
    );
    final TextEditingController dobController = TextEditingController(
      text: dob,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xfff7f6fa),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black87),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
              TextField(
                controller: dobController,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  labelStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black45),
            ),
          ),
          TextButton(
            onPressed: () async {
              await LocalStorage.updateUser(
                name: nameController.text,
                email: emailController.text,
              );
              setState(() {
                name = nameController.text;
                email = emailController.text;
                dob = dobController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile updated successfully")),
              );
            },
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.deepPurpleAccent),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    await LocalStorage.logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _openAddModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xfff6f4ee),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Transaction",
                style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
                  labelText: "Amount",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _selectedCategory,
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(value: cat, child: Text(cat)),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v!),
                decoration: const InputDecoration(
                  labelText: "Category",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _selectedType,
                items: ['Income', 'Expense']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedType = v!),
                decoration: const InputDecoration(
                  labelText: "Type",
                  labelStyle: TextStyle(color: Colors.black45),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _addTransaction,
                icon: const Icon(Icons.check_circle),
                label: const Text("Add Transaction"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🧠 Summary Card Widget
  Widget _summaryTile(String label, double value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generatePieSections() {
    final Map<String, double> summary = {};
    for (var t in _transactions) {
      String key = t['type'];
      if (!summary.containsKey(key)) {
        summary[key] = 0.0;
      }
      summary[key] = summary[key]! + t['amount'];
    }
    final colors = {'Income': Colors.greenAccent, 'Expense': Colors.redAccent};
    return summary.entries
        .map(
          (e) => PieChartSectionData(
            color: colors[e.key] ?? Colors.blueAccent,
            value: e.value > 0.0 ? e.value : 0.00001, // avoid zero slices
            title: e.key,
            titleStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            radius: 60,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f4ee), // Light, creamy background
      appBar: AppBar(
        title: const Text("FinTrack Dashboard"),
        backgroundColor: Colors.deepPurpleAccent.shade100,
        foregroundColor: Colors.deepPurple[800],
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: _openProfileDialog,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xffefeefd),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB4A0FF), Color(0xFFEBE5FF)],
                ),
              ),
              accountName: Text(
                name,
                style: const TextStyle(color: Colors.deepPurple),
              ),
              accountEmail: Text(
                email,
                style: const TextStyle(color: Colors.black87),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.deepPurpleAccent),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.deepPurple),
              title: const Text(
                "My Account",
                style: TextStyle(color: Colors.deepPurple),
              ),
              onTap: _openProfileDialog,
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
        onPressed: _openAddModal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD1F2FD), Color(0xFFFAEFFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                  ),
                  Text(
                    "\$${totalBalance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _summaryTile("Income", totalIncome, Colors.green[700]!),
                      _summaryTile("Expense", totalExpense, Colors.redAccent),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                // Make a fixed large height to avoid shrinking
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: PieChart(
                    PieChartData(
                      sections: _generatePieSections(),
                      sectionsSpace: 6,
                      centerSpaceRadius: 60,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Recent Transactions",
              style: TextStyle(
                color: Colors.deepPurple[700],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            ..._transactions.take(8).map((t) {
              return Dismissible(
                key: Key(t['id']),
                background: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.only(left: 32),
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.white, size: 32),
                      SizedBox(width: 16),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.only(right: 32),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete, color: Colors.white, size: 32),
                      SizedBox(width: 16),
                      Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => _deleteTransaction(t['id']),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: t['type'] == "Income"
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      child: Icon(
                        t['type'] == "Income"
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      t['title'],
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      '${t['category']} | ${t['date'].toString().substring(0, 10)}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: t['type'] == "Income"
                                  ? [Colors.greenAccent, Colors.green.shade100]
                                  : [Colors.redAccent, Colors.red.shade100],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete_forever_rounded),
                            color: Colors.white,
                            iconSize: 27,
                            tooltip: 'Delete',
                            splashRadius: 24,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierColor: Colors.black54.withOpacity(0.15),
                                builder: (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    "Delete Transaction",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "Are you sure you want to delete this transaction?",
                                    style: TextStyle(
                                      color: Colors.deepPurple[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                        _deleteTransaction(t['id']);
                                      },
                                      icon: const Icon(Icons.delete_forever),
                                      label: const Text("Delete"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          (t['type'] == "Income" ? "+" : "-") +
                              "\$${t['amount']}",
                          style: TextStyle(
                            color: t['type'] == "Income"
                                ? Colors.green[700]
                                : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
