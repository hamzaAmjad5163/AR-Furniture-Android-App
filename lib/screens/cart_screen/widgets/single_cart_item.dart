import 'package:arshop/models/product_model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../provider/app_provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({Key? key, required this.singleProduct}) : super(key: key);

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {

  int qty = 1;

  @override
  void initState() {
    qty = widget.singleProduct.qty ?? 1;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey, width: 1.3),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 140,
              child: Image.network(widget.singleProduct.image),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 150,
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
                            FittedBox(
                              child: Text(
                                widget.singleProduct.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10.0,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CupertinoButton(
                                  onPressed: (){
                                    if(qty > 1) {
                                      setState(() {
                                        qty--;
                                      });
                                      appProvider.updateQty(widget.singleProduct, qty);
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.remove),
                                  ),
                                ),

                                Text(qty.toString(), style: const TextStyle(fontSize: 18.0),),

                                CupertinoButton(
                                  onPressed: (){
                                    setState(() {
                                      qty++;
                                    });
                                    appProvider.updateQty(widget.singleProduct, qty);
                                  },
                                  padding: EdgeInsets.zero,
                                  child: const CircleAvatar(
                                    maxRadius: 13,
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){
                                if(!appProvider.getFavouriteProductList.contains(widget.singleProduct)) {
                                  appProvider.addFavouriteProduct(widget.singleProduct);
                                  showMessage("Item successfully added to wishlist");
                                }else {
                                  appProvider.removeFavouriteProduct(widget.singleProduct);
                                  showMessage("Item successfully removed from wishlist");
                                }
                              },
                              child: Text(
                                appProvider.getFavouriteProductList.contains(widget.singleProduct) ? "Remove to Wishlist" : "Add to Wishlist",
                                style: const TextStyle(
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

                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        appProvider.removeCartProduct(widget.singleProduct);
                        showMessage("Item successfully removed from cart");
                      },
                      child: const CircleAvatar(maxRadius: 13 ,child: Icon(Icons.delete, size: 17,),),
                    ),
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
