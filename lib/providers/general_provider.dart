import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GeneralProvider with ChangeNotifier {
  String supportMessage = '';
  bool isLoading = false;
  // Get Prices data
  Future<void> fetchSupportMessage() async {
    isLoading = true;
    notifyListeners();
    try {
      final http.Response response = await http.get(Uri.parse(
          'http://egymillers.atwebpages.com/view_app_supporters.php'));

      if (response.statusCode == 200) {
        supportMessage = response.body.toString();
      }
      else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}