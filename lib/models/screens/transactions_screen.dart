import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String searchQuery = '';
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> allTransactions = [
    {'title': 'Starbucks Coffee', 'category': 'Food', 'amount': -12.50, 'date': '2025-11-27', 'icon': Icons.coffee},
    {'title': 'Salary Deposit', 'category': 'Income', 'amount': 3500.00, 'date': '2025-11-25', 'icon': Icons.account_balance},
    {'title': 'Amazon Purchase', 'category': 'Shopping', 'amount': -89.99, 'date': '2025-11-24', 'icon': Icons.shopping_bag},
    {'title': 'Uber Ride', 'category': 'Transport', 'amount': -15.30, 'date': '2025-11-23', 'icon': Icons.local_taxi},
    {'title': 'Freelance Project', 'category': 'Income', 'amount': 450.00, 'date': '2025-11-22', 'icon': Icons.work},
    {'title': 'Grocery Store', 'category': 'Food', 'amount': -67.80, 'date': '2025-11-21', 'icon': Icons.shopping_cart},
    {'title': 'Netflix Subscription', 'category': 'Entertainment', 'amount': -14.99, 'date': '2025-11-20', 'icon': Icons.movie},
    {'title': 'Gym Membership', 'category': 'Health', 'amount': -45.00, 'date': '2025-11-19', 'icon': Icons.fitness_center},
  ];

  List<Map<String, dynamic>> get filteredTransactions {
    return allTransactions.where((txn) {
      // Apply search filter
      final matchesSearch = txn['title'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          txn['category'].toString().toLowerCase().contains(searchQuery.toLowerCase());

      // Apply category filter
      final matchesFilter = selectedFilter == 'All' ||
          (selectedFilter == 'Income' && (txn['amount'] as double) > 0) ||
          (selectedFilter == 'Expense' && (txn['amount'] as double) < 0) ||
          txn['category'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Transactions',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _filterChip('All'),
                  _filterChip('Income'),
                  _filterChip('Expense'),
                  _filterChip('Food'),
                  _filterChip('Shopping'),
                  _filterChip('Transport'),
                  _filterChip('Entertainment'),
                  _filterChip('Health'),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _filterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurpleAccent : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactions = filteredTransactions;

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
          'All Transactions',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list_rounded,
              color: selectedFilter != 'All' ? Colors.deepPurpleAccent : Colors.black87,
            ),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search transactions...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Active Filter Indicator
          if (selectedFilter != 'All')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Chip(
                    label: Text(selectedFilter),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        selectedFilter = 'All';
                      });
                    },
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.1),
                    labelStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
              ),
            ),

          // Transactions List or Empty State
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.search_off,
                            size: 60,
                            color: Colors.deepPurpleAccent.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'No Transactions Found',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Try adjusting your search or filter',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final txn = transactions[index];
                      final isIncome = (txn['amount'] as double) > 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
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
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isIncome ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                txn['icon'] as IconData,
                                color: isIncome ? const Color(0xFF16A34A) : const Color(0xFFEF4444),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    txn['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${txn['category']} • ${txn['date']}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${isIncome ? '+' : ''}\$${(txn['amount'] as double).abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isIncome ? const Color(0xFF16A34A) : const Color(0xFFEF4444),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
