import 'package:arshop/models/category_model/category_model.dart';
import 'package:arshop/widgets/appBar_title/top_title.dart';
import 'package:flutter/material.dart';

import '../../constants/routes.dart';
import '../../firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import '../../models/product_model/product_model.dart';
import '../product_detail/product_detail.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {

  List<ProductModel> productModelList = [];
  bool isLoading = false;

  void getCategoriesList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance.getCategoryViewProducts(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    getCategoriesList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: isLoading? Center(child: Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),) : SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight*1,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const BackButton(),
                Text(widget.categoryModel.name, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), )
              ],
            ),
          ),

          productModelList.isEmpty ? const Center(child: Text("No product to show."),)
              : Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: productModelList.length > 4 ? 4 : productModelList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.7,
                crossAxisCount: 2,
              ),
              itemBuilder: (ctx, index) {
                ProductModel singleProduct = productModelList[index];
                return Container(
                  decoration: BoxDecoration(
      
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: Column(
      
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Image.network(
                        singleProduct.image,
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        singleProduct.name,
                        style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "Price: \$${singleProduct.price}",
                        style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {
                                Routes.instance.push(ProductDetails(singleProduct: singleProduct,), context);
                              },
                              child: const Text("Buy",
                                style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),))),
                    ],
                  ),
                );
              },
            ),
          ),
      
          const SizedBox(height: 12.0,),
        ],
      ),
    ),
    );
  }
}
