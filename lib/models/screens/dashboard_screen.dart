import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart';
import 'wallet_screen.dart';
import 'analytics_screen.dart';
import 'transactions_screen.dart';
import 'help_support_screen.dart';
import '../utils/local_storage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// hey i czxcxzczxczxczx a Comment
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

  void _openProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    ).then((_) => _loadUser());
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
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  const Center(
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Type Selector (Income / Expense)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() => _selectedType = 'Income');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedType == 'Income'
                                  ? Colors.greenAccent.shade100.withOpacity(0.5)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedType == 'Income'
                                    ? Colors.green
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_downward_rounded,
                                  color: _selectedType == 'Income'
                                      ? Colors.green[700]
                                      : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Income",
                                  style: TextStyle(
                                    color: _selectedType == 'Income'
                                        ? Colors.green[800]
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setModalState(() => _selectedType = 'Expense');
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _selectedType == 'Expense'
                                  ? Colors.redAccent.shade100.withOpacity(0.5)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _selectedType == 'Expense'
                                    ? Colors.redAccent
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.arrow_upward_rounded,
                                  color: _selectedType == 'Expense'
                                      ? Colors.redAccent
                                      : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Expense",
                                  style: TextStyle(
                                    color: _selectedType == 'Expense'
                                        ? Colors.red[800]
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Amount Field
                  const Text(
                    "AMOUNT",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: Colors.deepPurpleAccent,
                      ),
                      hintText: "0.00",
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title Field
                  const Text(
                    "TITLE",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.edit_note,
                        color: Colors.deepPurpleAccent,
                      ),
                      hintText: "e.g. Grocery Shopping",
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Category Dropdown
                  const Text(
                    "CATEGORY",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.deepPurpleAccent,
                        ),
                        isExpanded: true,
                        items: _categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurpleAccent.withOpacity(
                                      0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.category_outlined,
                                    size: 18,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  cat,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged:
                            (v) => setModalState(() => _selectedCategory = v!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Add Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _addTransaction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Save Transaction",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _summaryTile(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
    
    final colors = {
      'Income': const Color(0xFF4ADE80),
      'Expense': const Color(0xFFF87171),
    };

    return summary.entries.map((e) {
      final isIncome = e.key == 'Income';
      return PieChartSectionData(
        color: colors[e.key] ?? Colors.grey,
        value: e.value > 0.0 ? e.value : 0.00001,
        title: '${(e.value / (totalIncome + totalExpense) * 100).toStringAsFixed(0)}%',
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        radius: isIncome ? 30 : 25,
        badgeWidget: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
              ),
            ],
          ),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            size: 16,
            color: colors[e.key],
          ),
        ),
        badgePositionPercentageOffset: 1.3,
      );
    }).toList();
  }

  Widget _drawerItem(IconData icon, String title, bool isActive, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? (isActive ? Colors.deepPurpleAccent : Colors.grey[600]),
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? (isActive ? Colors.deepPurpleAccent : Colors.black87),
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: isActive ? Colors.deepPurpleAccent.withOpacity(0.1) : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f4ee), // Light, creamy background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        leadingWidth: 80,
        leading: Builder(
          builder: (context) => Center(
            child: GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(Icons.menu_rounded, color: Colors.black87),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome Back,",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name.isNotEmpty ? name : "User",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: Container(
              width: 45,
              height: 45,
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              // Custom Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6B4EFF), Color(0xFF9882FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Text(
                          name.isNotEmpty ? name[0].toUpperCase() : "U",
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  children: [
                    _drawerItem(Icons.dashboard_rounded, "Dashboard", true, () => Navigator.pop(context)),
                    _drawerItem(Icons.account_balance_wallet_rounded, "My Wallet", false, () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                    }),
                    _drawerItem(Icons.pie_chart_rounded, "Analytics", false, () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
                    }),
                    _drawerItem(Icons.receipt_long_rounded, "Transactions", false, () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen()));
                    }),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1),
                    ),
                    _drawerItem(Icons.settings_rounded, "Settings", false, _openProfileScreen),
                    _drawerItem(Icons.help_outline_rounded, "Help & Support", false, () {
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
                    }),
                  ],
                ),
              ),
              
              // Logout
              Padding(
                padding: const EdgeInsets.all(24),
                child: _drawerItem(
                  Icons.logout_rounded,
                  "Logout",
                  false,
                  _logout,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        icon: const Icon(Icons.add),
        label: const Text("Add"),
        onPressed: _openAddModal,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Total Balance Card (Premium Gradient)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B4EFF), Color(0xFF9882FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B4EFF).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Balance",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "USD",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "\$${totalBalance.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _summaryTile("Income", totalIncome, Colors.white),
                        Container(
                          height: 40,
                          width: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _summaryTile("Expense", totalExpense, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),

              // 2. Chart Section (Donut Chart)
              if (_transactions.isNotEmpty)
                SizedBox(
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      PieChart(
                        PieChartData(
                          sections: _generatePieSections(),
                          sectionsSpace: 4,
                          centerSpaceRadius: 70,
                          startDegreeOffset: -90,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Net Balance",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${(totalIncome - totalExpense).toStringAsFixed(0)}",
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              else
                Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.pie_chart_outline, size: 60, color: Colors.grey[300]),
                      const SizedBox(height: 10),
                      Text(
                        "No data to show",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),

              // 3. Recent Transactions Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    onPressed: () {}, // TODO: Navigate to full list
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 4. Transaction List or Empty State
              if (_transactions.isEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.deepPurpleAccent.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.receipt_long_outlined,
                          size: 60,
                          color: Colors.deepPurpleAccent.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'No Transactions Yet',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Start tracking your finances by adding\nyour first transaction',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _openAddModal,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Transaction'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._transactions.take(8).map((t) {
                final isIncome = t['type'] == 'Income';
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                    children: [
                      // Icon Container
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isIncome 
                              ? const Color(0xFFDCFCE7) // Light Green
                              : const Color(0xFFFEE2E2), // Light Red
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          isIncome ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                          color: isIncome ? const Color(0xFF16A34A) : const Color(0xFFEF4444),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Title & Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${t['category']} • ${t['date'].toString().substring(0, 10)}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Amount & Delete
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${isIncome ? '+' : '-'}\$${t['amount']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isIncome ? const Color(0xFF16A34A) : const Color(0xFFEF4444),
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _deleteTransaction(t['id']),
                            child: const Icon(
                              Icons.delete_outline_rounded,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }
}
