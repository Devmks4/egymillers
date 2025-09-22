import 'dart:convert';
import 'package:egymillers/models/product_prices_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductsPricesProvider with ChangeNotifier {
  List<ProductPricesModel> _productPricesData = [];
  bool _isLoading = false;
  String updateMessage = '';
  List<ProductPricesModel> get productPricesData => _productPricesData;
  bool get isLoading => _isLoading;

  // Get Prices data
  Future<void> fetchPrices() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(Uri.parse('http://egymillers.atwebpages.com/get_prices.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _productPricesData = data.map((json) => ProductPricesModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
  // Update Prices data
  Future<void> updatePrices(int id , int currentPrice) async {

    final url = Uri.parse('http://egymillers.atwebpages.com/update_prices.php?id=$id&current_price=$currentPrice');
    final response = await http.get(url);
    if (response.statusCode == 200) {
        updateMessage = json.decode(response.body);
        await fetchPrices(); // refresh after update
    } else {
        updateMessage = "Error in Connection !!";
    }
    notifyListeners();
  }
}