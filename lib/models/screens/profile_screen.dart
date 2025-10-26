import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
  File? image;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await LocalStorage.getUserData();
    setState(() {
      name = user['name'] ?? '';
      email = user['email'] ?? '';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your custom colors
    final Color backgroundColor = const Color(0xFF232946); // Deep blue
    final Color cardColor = const Color(0xFF393E5B); // Slightly lighter blue
    final Color accentColor = const Color(0xFFF4D35E); // Accent yellow
    final Color textColor = Colors.white; // White for contrast
    final Color fieldFill = const Color(0xFF232946); // Match the background

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: cardColor,
        foregroundColor: accentColor,
        elevation: 0,
        iconTheme: IconThemeData(color: accentColor),
        titleTextStyle: const TextStyle(
          color: Color(0xFFF4D35E),
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: cardColor,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null
                    ? Icon(Icons.camera_alt, size: 40, color: accentColor)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: accentColor),
                filled: true,
                fillColor: fieldFill,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(text: name),
              onChanged: (v) => name = v,
            ),
            const SizedBox(height: 10),
            TextField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: accentColor),
                filled: true,
                fillColor: fieldFill,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: accentColor, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(text: email),
              onChanged: (v) => email = v,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(accentColor),
                  foregroundColor: MaterialStateProperty.all(backgroundColor),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 14),
                  ),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(2),
                ),
                onPressed: () async {
                  await LocalStorage.updateUser(name: name, email: email);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Profile updated!'),
                        backgroundColor: cardColor,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 2),
                        elevation: 3,
                      ),
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
