// This is a VULNERABLE approach! Never use it in production.

import 'package:http/http.dart' as http;

const String apiUrl = 'https://api.sample.com/data';
const String apiKey = 'YOUR_ACTUAL_API_KEY';

Future<http.Response> fetchData() async {
  final url = Uri.parse('$apiUrl?key=$apiKey');
  final response = await http.get(url);
  return response;
}
