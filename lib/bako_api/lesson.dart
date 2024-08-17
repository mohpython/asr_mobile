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
/// - `readingTime`: (Optional) The time taken to read the book (in seconds).
///
/// Returns a `Map<String, dynamic>?` containing the server's response data
/// if the bookmark is successfully created, or `null` otherwise.
Future<Map<String, dynamic>?> bookmark(String username, String bookTitle, String bookPageRef, int readingTime) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/bookmark/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'book_title': bookTitle,
      'book_page_ref': bookPageRef,
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

/// Marks a book as completed for a user and calculate his score.
///
/// Sends a POST request to the book completion API endpoint to mark
/// a specific book as completed for the given user.
///
/// Parameters:
/// - `username`: The username of the account.
/// - `bookTitle`: The title of the book to mark as completed.
/// - `numErrors`: (Optional) The number of errors made during reading.
/// - `readingTime`: (Optional) The time taken to read the book (in minutes).
///
/// Returns a `Map<String, dynamic>?` containing the server's response data
/// if the book is successfully marked as completed, or `null` otherwise.
Future<Map<String, dynamic>?> markBookAsCompleted(String username, String bookTitle, int readingTime, {int? numErrors}) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/book_completed/'),
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
