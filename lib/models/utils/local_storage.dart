import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  /// Saves user data to local storage.
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

  /// Authenticates user by matching email and password.
  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPass = prefs.getString('password');
    if (savedEmail == null || savedPass == null) {
      return false;
    }
    if (savedEmail == email && savedPass == password) {
      await prefs.setBool('loggedIn', true);
      return true;
    }
    return false;
  }

  /// Returns whether a user is currently logged in.
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  /// Logs the user out (clears stored user data except persistent app data).
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('loggedIn');
  }

  /// Retrieves stored user data: name and email.
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? '',
      'email': prefs.getString('email') ?? '',
    };
  }

  /// Updates the user's stored name and/or email.
  static Future<void> updateUser({String? name, String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      await prefs.setString('name', name);
    }
    if (email != null) {
      await prefs.setString('email', email);
    }
  }
}
