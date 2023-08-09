import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:e_commerce_app/features/admin/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    ProductsScreen(),
    ProductsScreen(),
    ProductsScreen(),
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
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 246, 246, 246)
                      // gradient: GlobalVariables.appBarGradient
                      ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Admin",
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      iconSize: 28,
                    )
                  ],
                ))
              ],
            ),
          )),
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
          // posts
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

          // Analytics

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(
                Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),

          //orders

          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: '',
          ),

          // CART
        ],
      ),
    );
  }
}
