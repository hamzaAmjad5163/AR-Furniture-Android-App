import 'package:arshop/constants/routes.dart';
import 'package:arshop/firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:arshop/models/product_model/product_model.dart';
import 'package:arshop/screens/custom_bottom_navbar/custom_bottom_bar.dart';
import 'package:arshop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';
import '../../stripe_helper/stripe_helper.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;

  const Checkout({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int groupValue = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 36.0,
            ),

            ///Cash on Delivery
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Cash on Delivery",
                    style:
                        TextStyle(fontSize: 18.0,fontFamily: 'Roboto', fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 24.0,
            ),

            ///Cash online
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      }),
                  const Icon(Icons.money),
                  const SizedBox(
                    width: 12.0,
                  ),
                  const Text(
                    "Online Payment",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Roboto',),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              title: "Continue",
              onPressed: () async {
                appProvider.clearBuyProduct();
                appProvider.addBuyProduct(widget.singleProduct);
                /*bool value = await FirebaseFirestoreHelper.instance
                    .uploadOrderProductFirebase(
                        appProvider.getBuyProductList, context, groupValue == 1 ? "Cash on Delivery": "paid");

                if(value){
                  Future.delayed(const Duration(seconds: 2), (){
                    Routes.instance.push(const CustomBottomBar(), context);
                  });
                }*/
                if (groupValue == 1) {
                  bool value = await FirebaseFirestoreHelper.instance
                      .uploadOrderProductFirebase(appProvider.getBuyProductList,
                      context, "Cash on Delivery");
                  appProvider.clearBuyProduct();
                  if (value) {
                    Future.delayed(const Duration(seconds: 2), () {
                      Routes.instance.push(const CustomBottomBar(), context);
                    });
                  }
                } else {
                  int value = double.parse(
                      appProvider.totalPriceBuyProductList().toString())
                      .round()
                      .toInt();
                  String totalPrice = (value * 100).toString();
                  await StripeHelper.instance
                      .makePayment(totalPrice.toString(), context);
                }
                },
            ),
          ],
        ),
      ),
    );
  }
}
