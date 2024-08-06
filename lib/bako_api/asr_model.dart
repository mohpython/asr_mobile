// import "dart:convert";
// import "package:http/http.dart" as http;

String inferenceASRModel(String? filePath) {
  /*if (filePath == null) return null;
  final response = await http.post(
    Uri.parse('http://yourapiurl.com/asr'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'file_path': filePath,
    }),
  );

  if (response.statusCode == 200) {
    final decodedString = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = jsonDecode(decodedString);
    return data;
  } else {
    return null;
  }*/
  return "A Hello world";
}