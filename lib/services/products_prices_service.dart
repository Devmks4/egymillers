import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_prices_model.dart';

class ProductsPricesService {

  Future <ProductPricesModel> getProductsPrices() async {
      final http.Response response = await http.get(Uri.parse('http://egymillers.atwebpages.com/get_prices.php'));
      Map<String, dynamic> prices = json.decode(response.body);
      ProductPricesModel productPricesModel = ProductPricesModel.fromJson(prices);
      return productPricesModel;
  }
}