import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asr_app/constant.dart' show bakoApiUri;

/// Adds a bookmark for a specific page in a book for a user.
///
/// Sends a POST request to the bookmark API endpoint with the username,
/// book title, and page reference to create a bookmark.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `bookTitle`: The title of the book to bookmark.
/// - `bookPageRef`: The reference to the specific page in the book.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data
/// if the bookmark is successfully created, or `null` otherwise.
Future<Map<String, dynamic>?> bookmark(String username, String bookTitle, String bookPageRef) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/bookmark/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'book_title': bookTitle,
      'book_page_ref': bookPageRef,
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

/// Marks a book as completed for a user.
///
/// Sends a POST request to the book completion API endpoint to mark
/// a specific book as completed for the given user.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `bookTitle`: The title of the book to mark as completed.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data
/// if the book is successfully marked as completed, or `null` otherwise.
Future<Map<String, dynamic>?> markBookAsCompleted(String username, String bookTitle) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/book_completed/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'book_title': bookTitle,
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

/// Calculates a score for a book reading session.
///
/// Sends a POST request to the score calculation API endpoint to calculate
/// the user's score for reading a specific book, based on errors and reading time.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `bookTitle`: The title of the book for which the score is being calculated.
/// - `numErrors`: (Optional) The number of errors made during reading.
/// - `readingTime`: (Optional) The time taken to read the book.
///
/// Returns a `Map<String, dynamic>?` containing the server's response data
/// with the calculated score if the operation is successful, or `null` otherwise.
Future<Map<String, dynamic>?> calculateScore(String username, String bookTitle, {int? numErrors, double? readingTime}) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/calculate_score/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'book_title': bookTitle,
      'num_errors': numErrors,
      'reading_time': readingTime,
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