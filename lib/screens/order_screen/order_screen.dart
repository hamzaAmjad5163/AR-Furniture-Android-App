import 'package:arshop/constants/colors.dart';
import 'package:arshop/firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:arshop/models/order_model/order_model.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: TColors.primary,
        title: const Text(
          "Your Orders",
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestoreHelper.instance.getUserOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Order Found"));
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (context, index) {
                OrderModel orderModel = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    collapsedShape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueGrey, width: 1.0),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 135,
                              width: 120,
                              color: Colors.grey,
                              child:
                                  Image.network(orderModel.products[0].image),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.products[0].name,
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  orderModel.products.length > 1
                                      ? SizedBox.fromSize()
                                      : Column(
                                          children: [
                                            Text(
                                              "Quantity: ${orderModel.products[0].qty.toString()}",
                                              style: const TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 12.0,
                                            ),
                                          ],
                                        ),
                                  Text(
                                    "Total Price:\$${orderModel.totalPrice.toString()}",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                  Text(
                                    "Order Status:${orderModel.status}",
                                    style: const TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              orderModel.status == "pending" ||
                                      orderModel.status == "delivery"
                                  ? SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3, // Adjust the width as needed
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseFirestoreHelper.instance
                                              .updateOrder(
                                                  orderModel, "cancel");
                                          orderModel.status = "cancel";
                                          setState(() {});
                                        },
                                        child: const Text("Cancel Order", style: TextStyle(color: Colors.white,fontFamily: 'Roboto', fontWeight: FontWeight.w400)),
                                      ),
                                    )
                                  : SizedBox.fromSize(),
                              const SizedBox(width: 12),
                              /*orderModel.status == "delivery"
                                  ? */SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3, // Adjust the width as needed
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseFirestoreHelper.instance
                                              .updateOrder(
                                                  orderModel, "completed");
                                          orderModel.status = "completed";
                                          setState(() {});
                                        },
                                        child: const Text("Delivery Order", style: TextStyle(fontFamily: 'Roboto', color: Colors.white, fontWeight: FontWeight.w400)),
                                      ),
                                    )
                                  /*: const SizedBox(width: 10),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                    children: orderModel.products.length > 1
                        ? [
                            const Text("Details", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),),
                            const Divider(
                              color: Colors.grey,
                            ),
                            ...orderModel.products.map((singleProduct) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 6.0),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          color: Colors.grey,
                                          child: Image.network(
                                              singleProduct.image),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleProduct.name,
                                                style: const TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Quantity: ${singleProduct.qty.toString()}",
                                                    style: const TextStyle(
                                                      /*fontWeight: FontWeight.bold,*/
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "Price:\$${singleProduct.price.toString()}",
                                                style: const TextStyle(
                                                  /*fontWeight: FontWeight.bold,*/
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                          ]
                        : [],
                  ),
                );
              });
        },
      ),
    );
  }
}
