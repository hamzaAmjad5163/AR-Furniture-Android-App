import 'package:arshop/favourite_screen/widgets/single_favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Screen", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700,),),
      ),
      body: appProvider.getFavouriteProductList.isEmpty ? const Center(child: Text("Add your Favourite Items."),)
          : ListView.builder(
          itemCount: appProvider.getFavouriteProductList.length,
          padding: const EdgeInsets.all(12.0),
          itemBuilder: (ctx, index) {
            return SingleFavouriteItem(singleProduct: appProvider.getFavouriteProductList[index],);
          }),
    );
  }
}
