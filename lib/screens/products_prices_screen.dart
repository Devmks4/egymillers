import 'package:egymillers/providers/product_prices_provider.dart';
import 'package:egymillers/screens/products_prices_update_screen.dart';
import 'package:egymillers/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


bool isAdmin = false;
List<dynamic> prices = [];

class ProductsPricesScreen extends StatefulWidget {
  const ProductsPricesScreen({super.key});

  @override
  _ProductsPricesScreen createState() => _ProductsPricesScreen();
}

class _ProductsPricesScreen extends State<ProductsPricesScreen> {
  @override
  initState(){
    super.initState();
    Future.microtask(()=> Provider.of<ProductsPricesProvider>(context, listen: false).fetchPrices());
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsPricesProvider>(context);
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
      floatingActionButton: productProvider.isLoading? null
          : FloatingActionButton(
              shape: CircleBorder(),
              onPressed:(){
                setState(() {
                  _openBottomSheetPassWord(context);
                });
                if (isAdmin == true) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProductsPricesUpdateScreen()));
                } },
              backgroundColor: primaryColor,
              child: Icon(
                Icons.edit,
                size: 32,
                color: Colors.white,
              ),
            ),
      body:   productProvider.isLoading?
      Center(child: CircularProgressIndicator())
          :
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: productProvider.productPricesData.length,
          itemBuilder: (context, index) {
            final productPriceModel = productProvider.productPricesData[index];
            return ProductTile(
                productName: productPriceModel.productName,
                productPrice: productPriceModel.productPrice,
                lastEdit: productPriceModel.lastDate,
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

void _openBottomSheetPassWord (BuildContext context) {
  TextEditingController controller = TextEditingController();
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'أدخل كلمة المرور',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (controller.text == '3697'){
                  Navigator.pop(context);
                  isAdmin = true;
                }
                else {
                  isAdmin = false;
                }

              },
              child: Text('إدخال'),
            ),
          ],
        ),
      );
    },
  );
}
