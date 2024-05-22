import 'package:arshop/constants/routes.dart';
import 'package:arshop/screens/buy_product/buy_product.dart';
import 'package:arshop/screens/cart_item_checkout/cart_item_checkout.dart';
import 'package:arshop/screens/cart_screen/widgets/single_cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';
import '../../provider/app_provider.dart';
import '../../widgets/primary_button/primary_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Sum:", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Text("\$${appProvider.totalPrice().toString()}", style: const  TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 25.0,),
              PrimaryButton(title: "Checkout", onPressed: (){

                appProvider.clearBuyProduct();
                appProvider.addBuyProductCartList();
                appProvider.clearCart();
                if(appProvider.getBuyProductList.isEmpty){
                  showMessage("Cart is Empty");
                }else{
                  Routes.instance.push(const CartItemCheckout(), context);
                }

              },),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cart Screen", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),),
      ),
      body: appProvider.getCartProductList.isEmpty ? const Center(child: Text("Cart is Empty."),)
          : ListView.builder(
          itemCount: appProvider.getCartProductList.length,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (ctx, index) {
            return SingleCartItem(singleProduct: appProvider.getCartProductList[index],);
      }),
    );
  }
}
