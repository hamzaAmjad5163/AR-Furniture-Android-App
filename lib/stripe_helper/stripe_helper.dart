// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../constants/routes.dart';
import '../firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../provider/app_provider.dart';
import '../screens/custom_bottom_navbar/custom_bottom_bar.dart';

class StripeHelper {
  static StripeHelper instance = StripeHelper();
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment(String amount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["client_secret"],
            style: ThemeMode.light,
            merchantDisplayName: "Abhi",
            googlePay: gpay,
          ))
          .then((value) {});

      displayPaymentSheet(context);
    } catch (e) {}
  }
  displayPaymentSheet(BuildContext context) async {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    try{
      await Stripe.instance.presentPaymentSheet().then((value) async {
        bool value = await FirebaseFirestoreHelper.instance
            .uploadOrderProductFirebase(
            appProvider.getBuyProductList,
            context,
            "paid online");
        appProvider.clearBuyProduct();
        if (value) {
          Future.delayed(const Duration(seconds: 2), () {
            Routes.instance.push(const CustomBottomBar(), context);
          });
        }
      });

    }
    catch (e) {

      print('$e');
    }
  }


  createPaymentIntent(String amount, String currency) async{
  try {
  Map<String, dynamic> body = {
  'amount': amount,
  'currency': currency,
  };

  var response = await http.post(

    Uri.parse("https://api.stripe.com/v1/payment_intents"),
    headers: {
    'Authorization': 'Bearer sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPIq00wmjWwZYA',
    'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
    );
    return json.decode(response.body);
  } catch (err) {
  throw Exception(err.toString());
  }
}
}
