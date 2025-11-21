import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('loggedIn', true);
  }

  // Hey ewwwwwwwwwwwwwwwwwwwwwww
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPass = prefs.getString('password');
    if (savedEmail == email && savedPass == password) {
      await prefs.setBool('loggedIn', true);
      return true;
    }
    return false;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? '',
      'email': prefs.getString('email') ?? '',
    };
  }

  static Future<void> updateUser({String? name, String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) await prefs.setString('name', name);
    if (email != null) await prefs.setString('email', email);
  }
}
