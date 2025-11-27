import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _showContactDialog(BuildContext context, String method, String details) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(method),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Contact us via $method:'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      details,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

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
          'Help & Support',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Options
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _contactCard(
              context,
              Icons.email_rounded,
              'Email Support',
              'support@fintrack.com',
              Colors.blue,
              () => _showContactDialog(context, 'Email Support', 'support@fintrack.com'),
            ),
            const SizedBox(height: 12),
            _contactCard(
              context,
              Icons.phone_rounded,
              'Phone Support',
              '+1 (555) 123-4567',
              Colors.green,
              () => _showContactDialog(context, 'Phone Support', '+1 (555) 123-4567'),
            ),
            const SizedBox(height: 12),
            _contactCard(
              context,
              Icons.chat_bubble_rounded,
              'Live Chat',
              'Available 24/7',
              Colors.deepPurpleAccent,
              () => _showInfoDialog(context, 'Live Chat', 'Live chat feature coming soon! We\'ll be available 24/7 to assist you.'),
            ),
            const SizedBox(height: 30),

            // FAQ Section
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _faqItem(
              context,
              'How do I add a transaction?',
              'Tap the "Add" button on the dashboard and fill in the transaction details including title, amount, category, and type (Income/Expense).',
            ),
            _faqItem(
              context,
              'Can I export my transaction history?',
              'Yes, go to Settings > Export Data to download your transaction history in CSV or PDF format.',
            ),
            _faqItem(
              context,
              'How do I change my password?',
              'Navigate to Settings > Security > Change Password. You\'ll need to enter your current password and then your new password twice.',
            ),
            _faqItem(
              context,
              'Is my financial data secure?',
              'Yes, we use bank-level 256-bit encryption to protect your data. All information is stored securely and never shared with third parties.',
            ),
            const SizedBox(height: 30),

            // Quick Links
            const Text(
              'Quick Links',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _quickLink(
              context,
              'Privacy Policy',
              Icons.privacy_tip_outlined,
              () => _showInfoDialog(context, 'Privacy Policy', 'Your privacy is important to us. We collect only essential data to provide you with the best experience.'),
            ),
            _quickLink(
              context,
              'Terms of Service',
              Icons.description_outlined,
              () => _showInfoDialog(context, 'Terms of Service', 'By using FinTrack, you agree to our terms and conditions. Please read them carefully.'),
            ),
            _quickLink(
              context,
              'About FinTrack',
              Icons.info_outline,
              () => _showInfoDialog(context, 'About FinTrack', 'FinTrack v1.0.0\n\nYour personal finance companion. Track expenses, manage budgets, and achieve your financial goals.'),
            ),
            _quickLink(
              context,
              'Rate Our App',
              Icons.star_outline,
              () => _showInfoDialog(context, 'Rate Our App', 'Thank you for using FinTrack! Your feedback helps us improve. Please rate us on the App Store or Google Play.'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactCard(BuildContext context, IconData icon, String title, String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
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
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _faqItem(BuildContext context, String question, String answer) {
    return GestureDetector(
      onTap: () => _showInfoDialog(context, question, answer),
      child: Container(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    answer,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _quickLink(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            Icon(icon, color: Colors.deepPurpleAccent, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}
