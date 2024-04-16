import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


Future<String> fetchCSRFToken() async {
  // final response = await http.get('http://10.0.2.2:8000/csrf_token/' as Uri);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/csrf_token/"),
      headers: <String, String>{
        'Authorization': 'Token $token',
        // 'X-CSRFToken': csrfToken,

      },
    );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to fetch CSRF token');
  }
}