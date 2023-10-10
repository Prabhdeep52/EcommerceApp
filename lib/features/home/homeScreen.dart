import 'package:e_commerce_app/features/home/widgets/TopCategories.dart';
import 'package:e_commerce_app/features/home/widgets/addressBar.dart';
import 'package:e_commerce_app/features/home/widgets/corousel.dart';
import 'package:e_commerce_app/features/home/widgets/dealOfTheDay.dart';
import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // final User = Provider.of<UserProvider>(context).user;

    return ScaffoldMessenger(
      // key: scaffoldMessengerKey,
      child: Scaffold(
          // appBar: PreferredSize(
          //     preferredSize: const Size.fromHeight(50),
          //     child: AppBar(
          //       flexibleSpace: Container(
          //         decoration:
          //             const BoxDecoration(color: Color.fromARGB(255, 246, 246, 246)
          //                 // gradient: GlobalVariables.appBarGradient
          //                 ),
          //       ),
          //       title: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           IconButton(
          //               onPressed: () {},
          //               icon: const Icon(Icons.view_sidebar_outlined)),
          //           Container(
          //             alignment: Alignment.topLeft,
          //             // child: Image.asset(
          //             //   'assets/images/amazon_in.png',
          //             //   width: 120,
          //             //   height: 45,
          //             //   color: Colors.black,
          //             // ),
          //             child: Text(
          //               "Styles  ",
          //               style: TextStyle(
          //                 color: Colors.amber[900],
          //                 fontSize: 29,
          //                 fontWeight: FontWeight.w600,
          //                 fontStyle: FontStyle.italic,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(
          //             width: 70,
          //           ),
          //           Container(
          //               padding: EdgeInsets.all(0),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   IconButton(
          //                     onPressed: () {},
          //                     icon: const Icon(Icons.notifications_outlined),
          //                     iconSize: 28,
          //                   ),
          //                   IconButton(
          //                     onPressed: () {},
          //                     icon: Icon(Icons.search, color: Colors.amber[900]),
          //                     iconSize: 28,
          //                   ),
          //                   IconButton(
          //                     onPressed: () {},
          //                     icon: const Icon(Icons.shopping_bag_outlined),
          //                     iconSize: 28,
          //                   )
          //                 ],
          //               ))
          //         ],
          //       ),
          //     )),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        // gradient: GlobalVariables.appBarGradient,
                        ),
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            margin: const EdgeInsets.only(left: 15),
                            child: Material(
                              borderRadius: BorderRadius.circular(7),
                              elevation: 1,
                              child: TextFormField(
                                // onFieldSubmitted:
                                decoration: InputDecoration(
                                  prefixIcon: InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 6,
                                      ),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black38,
                                      width: 1,
                                    ),
                                  ),
                                  hintText: 'Search',
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Container(
                          color: Colors.transparent,
                          height: 42,
                          child: const Icon(Icons.mic_none_outlined),
                        )
                      ]))),
          body: SingleChildScrollView(
            child: Column(
              children: const [
                AddressBar(),
                SizedBox(
                  height: 10,
                ),
                TopCategories(),
                SizedBox(
                  height: 10,
                ),
                CorouselImage(),
                DealOfTheDay()
              ],
            ),
          )),
    );
  }
}
