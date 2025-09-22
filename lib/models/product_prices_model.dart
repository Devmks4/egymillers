class ProductPricesModel {

String id;
String productName;
String productPrice;
String lastDate;

ProductPricesModel({
  required this.id,
  required this.productName,
  required this.productPrice,
  required this.lastDate
});

factory ProductPricesModel.fromJson(dynamic jsonData) {
    return ProductPricesModel(
    id: jsonData['id'],
    productName: jsonData['product_name'],
    productPrice: jsonData['current_price'],
    lastDate: jsonData['last_date']
    );
}
}