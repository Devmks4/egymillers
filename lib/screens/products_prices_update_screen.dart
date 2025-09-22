import 'package:egymillers/screens/products_prices_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_prices_provider.dart';
import '../shared/styles/colors.dart';

class ProductsPricesUpdateScreen extends StatefulWidget {
  const ProductsPricesUpdateScreen({super.key});

  @override
  State<ProductsPricesUpdateScreen> createState() => _ProductsPricesUpdateScreenState();
}

class _ProductsPricesUpdateScreenState extends State<ProductsPricesUpdateScreen> {

  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsPricesProvider>(context);
    return Scaffold(
      backgroundColor: scaffoldBackGround,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.replace(context, oldRoute: MaterialPageRoute(
                builder: (context) => ProductsPricesUpdateScreen()), newRoute: MaterialPageRoute(
                builder: (context) => ProductsPricesScreen()),);
          },
        ),
        backgroundColor: primaryColor,
        title: Text(
          'تعديل الأسعار',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body : Consumer<ProductsPricesProvider>(
        builder: (BuildContext context, ProductsPricesProvider value, Widget? child) {
          if (value.isLoading || value.productPricesData.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView.builder(
              itemCount: productProvider.productPricesData.length,
              itemBuilder: (context, index) {
                final product = productProvider.productPricesData[index];
                final priceController = TextEditingController(text: product.productPrice);
                return
                  Padding(
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
                              ElevatedButton(
                                onPressed: () {
                                                if(priceController.text.isNotEmpty){
                                                  productProvider.updatePrices(int.parse(product.id), int.parse(priceController.text));
                                                }
                                },
                                child: Icon(Icons.edit),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextFormField(
                                  controller: priceController,
                                    decoration: InputDecoration(
                                        labelText: product.productPrice,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        )
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'هذا الحقل مطلوب';
                                      }
                                      return null;
                                    }
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: primaryColor,
                                radius: 32,
                                child: Text(
                                  product.productName,
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
              },
            ),
          );
        }
        ),
    );
  }
}