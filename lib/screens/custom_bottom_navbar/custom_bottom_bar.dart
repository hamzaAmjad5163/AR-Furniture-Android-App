// ignore_for_file: library_private_types_in_public_api

import "package:arshop/favourite_screen/favourite_screen.dart";
import "package:arshop/screens/cart_screen/cart_screen.dart";
import "package:arshop/screens/home/home.dart";
import "package:flutter/material.dart";
import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";

import "../account_screen/account_screen.dart";


class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({final Key? key})
      : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {

  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;


  List<Widget> _buildScreens() => [
    const Home(),
    const CartScreen(),
    const FavouriteScreen(),
    const AccountScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      inactiveIcon: const Icon(Icons.home_outlined),
      title: "Home",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.shopping_cart),
      inactiveIcon: const Icon(Icons.shopping_cart_outlined),
      title: "Cart",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,
    ),
    /*PersistentBottomNavBarItem(
      icon: const Icon(Icons.circle),
      inactiveIcon: const Icon(Icons.circle_outlined),
      title: "Orders",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,
    ),*/
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.favorite),
      inactiveIcon: const Icon(Icons.favorite_outline),
      title: "Favorite",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,

    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      inactiveIcon: const Icon(Icons.person_outline),
      title: "Account",
      activeColorPrimary: Colors.white,
      inactiveColorPrimary: Colors.white70,

    ),
  ];

  @override
  Widget build(final BuildContext context) => Scaffold(

    body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      resizeToAvoidBottomInset: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
          ? 0.0
          : kBottomNavigationBarHeight,
      bottomScreenMargin: 0,

      backgroundColor: Theme.of(context).primaryColor,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(colorBehindNavBar: Theme.of(context).canvasColor),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle
          .neumorphic, // Choose the nav bar style with this property
    ),
  );
}
