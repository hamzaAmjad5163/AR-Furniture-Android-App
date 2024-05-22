import 'package:arshop/models/product_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../provider/app_provider.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleFavouriteItem({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 1.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 140,
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),



                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                                appProvider.removeFavouriteProduct(widget.singleProduct);
                                showMessage("Item successfully removed from Wishlist");
                              },
                              child: const Text(
                                "Removed from Wishlist",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.0,
                                  color: Color(0xffF94F46),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Text(
                          "\$${widget.singleProduct.price.toString()}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),

                    /*CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
                        appProvider.removeCartProduct(widget.singleProduct);
                        showMessage("Item successfully removed from cart");
                      },
                      child: const CircleAvatar(maxRadius: 13 ,child: Icon(Icons.delete, size: 17,),),
                    ),*/
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
