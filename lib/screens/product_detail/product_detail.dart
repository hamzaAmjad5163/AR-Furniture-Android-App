import 'package:arshop/constants/constant.dart';
import 'package:arshop/constants/routes.dart';
import 'package:arshop/favourite_screen/favourite_screen.dart';
import 'package:arshop/models/product_model/product_model.dart';
import 'package:arshop/provider/app_provider.dart';
import 'package:arshop/screens/buy_product/buy_product.dart';
import 'package:arshop/screens/cart_screen/cart_screen.dart';
import 'package:arshop/screens/product_detail/widget/virtual_ar_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {

  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);
  final ProductModel singleProduct;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Routes.instance.push(const CartScreen(), context);
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 400,
                width: 400,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name: ${widget.singleProduct.name}",
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          widget.singleProduct.isFavourite =
                              !widget.singleProduct.isFavourite;
                        });
                        if (widget.singleProduct.isFavourite) {
                          appProvider.addFavouriteProduct(widget.singleProduct);
                        } else {
                          appProvider
                              .removeFavouriteProduct(widget.singleProduct);
                        }
                      },
                      icon: Icon(appProvider.getFavouriteProductList
                              .contains(widget.singleProduct)
                          ? Icons.favorite
                          : Icons.favorite_border)),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.singleProduct.description),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),

              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      if (qty >= 1) {
                        setState(() {
                          qty--;
                        });
                      }
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    qty.toString(),
                    style: const TextStyle(
                        fontSize: 22.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      setState(() {
                        qty++;
                      });
                    },
                    padding: EdgeInsets.zero,
                    child: const CircleAvatar(
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24.0,
              ),

              ///AR BUTTON
              Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: ()
                  {
                    ///try Item virtually
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> VirtualARViewScreen(
                      clickedItemImageLink: widget.singleProduct!.image.toString(),
                    )));
                  },

                  label: const Text(
                      "Try Product (AR View)"
                  ),
                  icon: const Icon(
                    Icons.mobile_screen_share_rounded,
                    color: Colors.white,
                  ),
                ),
              ),

              //const Spacer(),
              const SizedBox(
                height: 24.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        ProductModel productModel =
                            widget.singleProduct.copyWith(qty: qty);
                        appProvider.addCartProduct(productModel);
                        showMessage("Item successfully added to cart");
                      },
                      child: const Text("ADD TO CART")),
                  const SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                      height: 38,
                      width: 140,
                      child: ElevatedButton(
                          onPressed: () {
                            ProductModel productModel =
                                widget.singleProduct.copyWith(qty: qty);
                            Routes.instance.push(
                                Checkout(singleProduct: productModel), context);
                          },
                          child: const Text("BUY"),
                      ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
