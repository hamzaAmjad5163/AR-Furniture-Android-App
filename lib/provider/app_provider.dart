import 'dart:io';

import 'package:arshop/constants/constant.dart';
import 'package:arshop/firebase_helpers/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:arshop/firebase_helpers/firebase_storage/firebase_storage_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model/product_model.dart';
import '../models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
  ///Cart
  final List<ProductModel> _cartProductList = [];
  final List<ProductModel> _buyProductList = [];

  late UserModel _userModel; // Declare _userModel as late

  // Initialize _userModel as null
  AppProvider() {
    _userModel = UserModel(
        id: FirebaseAuth.instance.currentUser!.uid,
        name: FirebaseAuth.instance.currentUser!.displayName!,
        email: FirebaseAuth.instance.currentUser!.email!);
    getUserInfoFirebase(); // Fetch user information asynchronously
  }

  UserModel get getUserInformation => _userModel;

  void addCartProduct(ProductModel productModel) {
    _cartProductList.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductList;

  /// Favourites
  final List<ProductModel> _favouriteProductList = [];

  void addFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.add(productModel);
    notifyListeners();
  }

  void removeFavouriteProduct(ProductModel productModel) {
    _favouriteProductList.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavouriteProductList => _favouriteProductList;

  ///user information (profile)

  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserInformation();
    notifyListeners();
  }

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel.id)
          .set(_userModel.toJson());

      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel.id)
          .set(_userModel.toJson());
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pop();
    }
    showMessage("Successfully updated profile");
    notifyListeners();
    /*Navigator.of(context).pop();*/
  }


  ///total price
  double totalPrice(){
    double totalPrice = 0.0;
    for (var element in _cartProductList){
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }
  double totalPriceBuyProductList(){
    double totalPrice = 0.0;
    for (var element in _buyProductList){
      totalPrice += element.price * element.qty!;
    }
    return totalPrice;
  }


  ///update qty
  void updateQty(ProductModel productModel, int qty) {
    int index = _cartProductList.indexOf(productModel);
    _cartProductList[index].qty = qty;
    notifyListeners();
  }


  ///list of buy product

  void addBuyProduct(ProductModel model){
    _buyProductList.add(model);
    notifyListeners();
  }

  void addBuyProductCartList(){
    _buyProductList.addAll(_cartProductList);
    notifyListeners();
  }
  void clearCart(){
    _cartProductList.clear();
      notifyListeners();
  }
  void clearBuyProduct(){
    _buyProductList.clear();
    notifyListeners();
  }

  List<ProductModel> get getBuyProductList => _buyProductList;
}
