import 'package:arshop/constants/routes.dart';
import 'package:arshop/firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:arshop/provider/app_provider.dart';
import 'package:arshop/screens/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product_model/product_model.dart';
import '../../../widgets/appBar_title/top_title.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({Key? key}) : super(key: key);

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getProductsList();
    super.initState();
  }

  void getProductsList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();
    productModelList.shuffle();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  TextEditingController search = TextEditingController();
  List<ProductModel> searchList = [];

  void searchProduct(String value) {
    searchList = productModelList
        .where((element) =>
        element.name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('All Products', style: TextStyle(fontFamily: 'Roboto', color: Colors.white),),
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  TextFormField(
                    controller: search,
                    onChanged: (String value) {
                      searchProduct(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Search here...",
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  // Remove the "Categories" text here
                ],
              ),
            ),

            // Remove the categories section here

            const SizedBox(
              height: 12.0,
            ),
            !isSearched()
                ? const Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products List",
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  // Remove the "View All" button here
                ],
              ),
            )
                : SizedBox.fromSize(),

            const SizedBox(
              height: 12.0,
            ),

            search.text.isNotEmpty && searchList.isEmpty
                ? const Center(
              child: Text("No Product Found"),
            )
                : searchList.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 50),
                shrinkWrap: true,
                primary: false,
                itemCount: searchList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (ctx, index) {
                  ProductModel singleProduct =
                  searchList[index];
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          "Price: \$${singleProduct.price}",
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                                onPressed: () {
                                  Routes.instance.push(
                                      ProductDetails(
                                        singleProduct:
                                        singleProduct,
                                      ),
                                      context);
                                },
                                child: const Text(
                                  "Buy",
                                )))
                      ],
                    ),
                  );
                },
              ),
            )
                : productModelList.isEmpty
                ? const Center(
              child: Text("No product to show."),
            )
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 50),
                shrinkWrap: true,
                primary: false,
                itemCount: productModelList.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                ),
                itemBuilder: (ctx, index) {
                  ProductModel singleProduct =
                  productModelList[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(8.0),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          "Price: \$${singleProduct.price}",
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        SizedBox(
                            height: 45,
                            width: 140,
                            child: OutlinedButton(
                                onPressed: () {
                                  Routes.instance.push(
                                      ProductDetails(
                                        singleProduct:
                                        singleProduct,
                                      ),
                                      context);
                                },
                                child: const Text(
                                  "Buy",
                                )))
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  bool isSearched() {
    if (search.text.isNotEmpty && searchList.isEmpty) {
      return true;
    } else if (search.text.isEmpty && searchList.isNotEmpty) {
      return false;
    } else if (searchList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
