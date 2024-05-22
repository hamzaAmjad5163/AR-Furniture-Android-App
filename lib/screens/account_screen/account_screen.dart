import 'package:arshop/constants/colors.dart';
import 'package:arshop/constants/routes.dart';
import 'package:arshop/favourite_screen/favourite_screen.dart';
import 'package:arshop/screens/change_password/change_password.dart';
import 'package:arshop/screens/edit_profile/edit_profile.dart';
import 'package:arshop/screens/order_screen/order_screen.dart';
import 'package:arshop/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase_helpers/firebase_auth_helper/firebase_auth_helper.dart';
import '../../provider/app_provider.dart';
import '../about_us/about_us.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: const Text(
          "Account",
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700, color: Colors.white,),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Column(
            children: [
              appProvider.getUserInformation.image==null
                  ? const Icon(
                      Icons.person_outline,
                      size: 120,
                    )
                  : CircleAvatar(
                      radius: 55,
                      backgroundImage:
                          NetworkImage(appProvider.getUserInformation.image!),
                    ),
              Text(
                appProvider.getUserInformation.name,
                style:
                    const TextStyle(fontSize: 18, fontFamily: 'Roboto', fontWeight: FontWeight.w400),
              ),
              Text(appProvider.getUserInformation.email, style: const TextStyle(color: Colors.grey),),

              SizedBox(
                  width: 150,
                  child: PrimaryButton(
                    title: "Edit Profile",

                    onPressed: () {
                      Routes.instance.push(const EditProfile(), context);
                    },
                  )),
            ],
          )),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.instance.push( OrderScreen(), context);
                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400, )),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(const FavouriteScreen(), context);
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourites", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400 ),),
                ),

                ListTile(
                  onTap: () {
                    Routes.instance.push(const AboutUs(), context);
                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About Us", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),),
                ),
                ListTile(
                  onTap: () {
                    Routes.instance.push(const ChangePassword(), context);
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400 ),),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.instance.signOut();
                    setState(() {});
                  },
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text("Log Out", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("version 1.0.0", style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
