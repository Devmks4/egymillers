import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class ProductsPricesScreen extends StatefulWidget {
  const ProductsPricesScreen({super.key});

  @override
  _ProductsPricesScreen createState() => _ProductsPricesScreen();
}

class _ProductsPricesScreen extends State<ProductsPricesScreen> {
  List<dynamic> prices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPrices();
  }
  Future<void> fetchPrices() async {
    final response = await http.get(Uri.parse('http://egymillers.atwebpages.com/get_prices.php'));

    if (response.statusCode == 200) {
      setState(() {
        prices = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('لا يمكن تحميل الأسعار');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'بورصة المنتجات',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
      ?  Center(child: CircularProgressIndicator())
          :
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: prices.length,
          itemBuilder: (context, index) {
            final product = prices[index];
            return ProductTile(
                productName: product["product_name"],
                productPrice: product["current_price"].toString(),
                lastEdit: product["last_date"]
            );
          },
        ),
      ),
    );
  }
}
class ProductTile extends StatelessWidget {
  final String productName,productPrice,lastEdit;

  const ProductTile({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.lastEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  color: scaffoldBackGround,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    spacing: 6,
                    children: [
                      Row(
                        spacing: 16,
                        children: [
                          Text('جنيه مصري',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primaryColor
                            ),
                          ),
                          Text(
                              productPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: primaryColor
                            ),
                          ),
                        ],
                      ),
                      Text(
                        lastEdit,
                        style: TextStyle(
                            color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 32,
                    child: Text(
                        productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,)
          ],
      ),
    );
  }
}
