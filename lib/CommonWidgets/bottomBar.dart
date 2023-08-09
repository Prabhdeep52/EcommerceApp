import 'package:badges/badges.dart' as badges;
import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:e_commerce_app/features/accounts/screens/accountScreen.dart';
import 'package:e_commerce_app/features/auth/screens/authScreen.dart';
import '../features/home/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    HomeScreen(),
    AccountScreen(),
    Center(
      child: Text("carts"),
    ),
    // Center(
    //   child: Text("hh"),
    // ),
    // Center(
    //   child: Text("hh"),
    // ),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 30,
        elevation: 0,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.only(top: 1, bottom: 0),
              width: bottomBarWidth,
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            label: '',
          ),

          // CART
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const badges.Badge(
                badgeContent:
                    Text("3", style: TextStyle(fontWeight: FontWeight.bold)),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Color.fromARGB(255, 255, 255, 255),
                  padding: EdgeInsets.only(left: 0, right: 13),
                  elevation: 0,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
