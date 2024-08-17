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

/// Stores the list of model transcription accuracies values as strings in the SharedPreferences.
///
/// This function converts a `List<double>` into a `List<String>` and saves it in
/// SharedPreferences. This is necessary because SharedPreferences does not directly support
/// storing lists of doubles.
///
/// Parameters:
/// - `key` (String): The key under which the list of accuracies will be stored.
/// - `accuracies` (List<double>): The list of transcription accuracies to be stored.
///
/// Returns:
/// - `Future<void>`: A Future that completes when the data has been stored.
Future<void> storeAccuracies(String key, List<double> accuracies) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert List<double> to List<String>
  List<String> stringList = accuracies.map((double value) => value.toString()).toList();
  // Store the List<String> in SharedPreferences
  await prefs.setStringList(key, stringList);
}

/// Retrieves the list of model transcription accuracies values from SharedPreferences.
///
/// This function fetches a `List<String>` from SharedPreferences and converts it back
/// to a `List<double>`. If the key does not exist in SharedPreferences, it returns an
/// empty list.
///
/// Parameters:
/// - `key` (String): The key under which the list of accuracies is stored.
///
/// Returns:
/// - `Future<List<double>>`: A Future that completes with the retrieved list of doubles
///   or an empty list if the key does not exist.
Future<List<double>> getAccuracies(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve the List<String> from SharedPreferences
  List<String>? stringList = prefs.getStringList(key);

  // Convert List<String> back to List<double>
  if (stringList != null) {
    return stringList.map((String value) => double.parse(value)).toList();
  } else {
    // Return an empty list if the key doesn't exist
    return [];
  }
}

/// Deletes the stored list of accuracies from SharedPreferences.
///
/// Parameters:
/// - `key`: The key associated with the list of accuracies to delete. (Usually bookTitle)
///
/// Returns a `Future<void>` indicating the completion of the deletion process.
Future<void> deleteAccuracies(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Remove the list of accuracies associated with the key
  await prefs.remove(key);
}
