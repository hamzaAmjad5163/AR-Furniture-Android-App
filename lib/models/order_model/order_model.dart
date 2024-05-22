import '../product_model/product_model.dart';


class OrderModel {
  OrderModel({
    required this.orderId,
    required this.payment,
    required this.status,
    required this.products,
    required this.totalPrice,
    required this.userId,
  });

  String orderId;
  String userId;
  String status;
  String payment;
  List<ProductModel> products;
  double totalPrice;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"];
    return OrderModel(
      orderId: json["orderId"],
      products: productMap.map((e) => ProductModel.fromJson(e)).toList(),
      totalPrice: json["totalPrice"],
      status: json["status"],
      payment: json["payment"],
      userId: json["userId"],
    );
  }


}
