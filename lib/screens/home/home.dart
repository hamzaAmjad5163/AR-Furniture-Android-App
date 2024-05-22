import 'package:arshop/constants/routes.dart';
import 'package:arshop/firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:arshop/provider/app_provider.dart';
import 'package:arshop/screens/category_view/category_view.dart';
import 'package:arshop/screens/home/widget/view_all_product.dart';
import 'package:arshop/screens/product_detail/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../../models/category_model/category_model.dart';
import '../../models/product_model/product_model.dart';
import '../../widgets/appBar_title/top_title.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoriesList();
    super.initState();
    // Start timer when the widget is initialized
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void getCategoriesList() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
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
                          const TopTitle(title: 'AR SHOP', subtitle: ""),
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
                          const Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ),
                        ],
                      )),

                  ///

                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Empty Category"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Routes.instance.push(
                                            CategoryView(categoryModel: e),
                                            context);
                                      },
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: Card(
                                          color: Colors.white,
                                          elevation: 3.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          child: SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(e.image,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),

                  // Horizontal Slider with Banners
                  SizedBox(
                    height: 100,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        Image.network(
                          'https://th.bing.com/th/id/OIP.AR0U8BEkvUvJzwR24x-eUQAAAA?rs=1&pid=ImgDetMain',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://tse2.mm.bing.net/th?id=OIP.MDUOC0BV_YfyIF6xYox61gHaC-',
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          'https://tse1.mm.bing.net/th?id=OIP.aEaXtzhpVfOYl3qW9M4gDwHaCr',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 12.0,
                  ),
                  !isSearched()
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Top Products",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Routes.instance
                                        .push(const AllProductsView(), context);
                                  },
                                  child: const Text("View All"))
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
                                    itemCount: productModelList.length > 4
                                        ? 4
                                        : productModelList.length,
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

//List<ProductModel> bestProducts = [

//ProductModel(
//id: "4",
//name: "Royal Chair",
//image: "assets/images/category4.png",
// price: "210",
// description:
//      "The Royal Chair exudes elegance and sophistication, making it a luxurious addition to any space. Crafted with meticulous attention to detail, this chair combines timeless design with opulent materials to create a regal seating experience.",
//  status: "pending",
//    isFavourite: false),
//];
