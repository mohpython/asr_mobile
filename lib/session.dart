import 'package:shared_preferences/shared_preferences.dart';
import 'package:asr_app/bako_api/user.dart' show getUser;

/// Manages user session information using shared preferences.
///
/// The `SessionManager` class provides static methods to handle user session
/// data such as login status and username, using the `SharedPreferences`
/// package to persist this data across app launches.
///
/// Methods:
/// - `setLoggedIn`: Marks the user as logged in and stores the username.
/// - `isLoggedIn`: Checks if the user is currently logged in.
/// - `getUserData`: Retrieves the information of the logged-in user.
/// - `logout`: Logs the user out by updating the session status.
///
/// ```
class SessionManager {
  static const String _isLoggedInKey = "isLoggedIn";
  static const String _usernameKey = "username";

  /// Sets the login status to true and stores the username.
  ///
  /// Parameters:
  /// - `username`: The username of the user to store in shared preferences.
  static Future<void> setLoggedIn(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_usernameKey, username);
    prefs.setBool(_isLoggedInKey, true);
  }

  /// Checks if the user is currently logged in.
  ///
  /// Returns `true` if the user is logged in, `false` otherwise.
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Retrieves the information of the logged-in user.
  ///
  /// Returns a Map representing server response if request was successful, or `null` else.
  static Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(_usernameKey);

    if (username != null){
      Map<String, dynamic>? userData = await getUser(username);
      return userData;
    }
  }

  /// Logs the user out by setting the login status to false.
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInKey, false);
  }
}
