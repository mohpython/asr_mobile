import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asr_app/constant.dart' show bakoApiUri;

/// Creates a new reader account with the provided username and password.
///
/// Sends a POST request to the account creation API endpoint. Optionally includes
/// first name and surname in the request body.
///
/// Parameters:
/// - `username`: The desired username for the account.
/// - `password`: The desired password for the account.
/// - `firstname`: (Optional) The first name of the user.
/// - `surname`: (Optional) The surname of the user.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// account creation is successful, or `null` otherwise.
Future<Map<String, dynamic>?> createReaderAccount(String username, String password, {String? firstname, String? surname}) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/account_creation/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
      'firstname': firstname,
      'surname': surname,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}

/// Logs in a reader user with the provided username and password.
///
/// Sends a POST request to the login API endpoint.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `password`: The password of the account.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// login is successful, or `null` otherwise.
Future<Map<String, dynamic>?> loginReaderUser(String username, String password) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/login/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}

/// Retrieve the information of a specific user with the given username, this implicitly assume the User has already logged in.
///
/// Sends a POST request to the /user API endpoint.
///
/// Parameters:
/// - `username`: The username of the account.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// account exists , or `null` otherwise.
Future<Map<String, dynamic>?> getUser(String username) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/user/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}

/// Edits the username of an existing reader account.
///
/// Sends a POST request to the change username API endpoint.
///
/// Parameters:
/// - `currentUsername`: The current username of the account.
/// - `newUsername`: The new desired username for the account.
/// - `password`: The password of the account.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// username change is successful, or `null` otherwise.
Future<Map<String, dynamic>?> editUsername(String currentUsername, String newUsername, String password) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/change_username/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'current_username': currentUsername,
      'new_username': newUsername,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}

/// Edits the password of an existing reader account.
///
/// Sends a POST request to the change password API endpoint.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `currentPassword`: The current password of the account.
/// - `newPassword`: The new desired password for the account.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// password change is successful, or `null` otherwise.
Future<Map<String, dynamic>?> editPassword(String username, String currentPassword, String newPassword) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/change_password/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'current_password': currentPassword,
      'new_password': newPassword,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}

/// Deletes an existing reader account.
///
/// Sends a POST request to the account deletion API endpoint.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `password`: The password of the account.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data if the
/// account deletion is successful, or `null` otherwise.
Future<Map<String, dynamic>?> deleteAccount(String username, String password) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/account_deletion/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}
