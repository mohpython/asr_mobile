import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:asr_app/constant.dart' show bakoApiUri;

/// Retrieves a specific book by its title.
///
/// Sends a POST request to the book API endpoint to fetch the details
/// of the book with the specified title.
///
/// Parameters:
/// - `title`: The title of the book to retrieve.
///
/// Returns a `Map<String, dynamic>?` containing the book details
/// if the book is successfully retrieved, or `null` otherwise.
Future<Map<String, dynamic>?> getBook(String title) async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/book/'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'title': title,
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

/// Retrieves the catalog of available books.
///
/// Sends a POST request to the catalog API endpoint to fetch a list
/// of all available books.
///
/// Returns a `Map<String, dynamic>?` containing the catalog data
/// if the catalog is successfully retrieved, or `null` otherwise.
Future<Map<String, dynamic>?> getCatalog() async {
  final response = await http.post(
    Uri.parse('$bakoApiUri/catalog/'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Decode the response body using UTF-8
    final decodedString = utf8.decode(response.bodyBytes);
    // Convert the decoded response to a Map
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  }
}
