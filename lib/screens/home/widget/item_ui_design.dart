
import 'package:arshop/models/product_model/product_model.dart';
import 'package:arshop/screens/product_detail/product_detail.dart';
import 'package:flutter/material.dart';

class ItemUIDesignWidget extends StatefulWidget {
  final ProductModel? singleProduct;
  BuildContext? context;

  ItemUIDesignWidget({super.key,
    this.singleProduct,
    this.context,
  });

  @override
  State<ItemUIDesignWidget> createState() => _ItemUIDesignWidgetState();
}

class _ItemUIDesignWidgetState extends State<ItemUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // send user item detail to the main screen which are uploaded
        Navigator.push(context, MaterialPageRoute(builder: (c)=> ProductDetails(
          singleProduct: widget.singleProduct!,
        )));
      },
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              //image
              Image.network(
                widget.singleProduct!.image.toString(),
                width: 150,
                height: 150,
              ),

              const SizedBox(width: 4.0,),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),

                    //item name
                    Expanded(
                      child: Text(
                        widget.singleProduct!.name.toString(),
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),

                    //display the seller name then
                    Expanded(
                      child: Text(
                        widget.singleProduct!.description.toString(),
                        maxLines: 2,
                        style:const TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20.0,),

                    //display the discount badge
                    //new price
                    //original price
                    Row(
                      children: [
                        //50% off badge
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.indigo,
                          ),
                          alignment: Alignment.topLeft,
                          width: 40,
                          height: 44,
                          child:  const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "50%",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,

                                  ),
                                ),

                                Text(
                                  "OFF",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 10,),

                        //price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //original price
                            Row(
                              children: [
                                const Text(
                                  "Original Price: \$",
                                  style: TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),

                                Text(
                                  (double.parse(widget.singleProduct!.price! as String) + double.parse(widget.singleProduct!.price! as String)).toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),

                            //discount price or new price we can say
                            Row(
                              children: [
                                Text(
                                  "New Price: ",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),

                                Text(
                                  "\$",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),

                                Text(
                                  widget.singleProduct!.price.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                      ],
                    ),

                    const SizedBox(width: 8.0,),
                    const Divider(
                      height: 4,
                      color: Colors.grey,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
