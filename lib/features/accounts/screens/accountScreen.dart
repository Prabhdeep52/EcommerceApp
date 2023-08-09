// ignore_for_file: sized_box_for_whitespace

import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:e_commerce_app/features/accounts/widgets/accountScreenOptions.dart';
import 'package:e_commerce_app/features/accounts/widgets/orders.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 246, 246, 246)
                    // gradient: GlobalVariables.appBarGradient
                    ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // child: Image.asset(
                    //   'assets/images/amazon_in.png',
                    //   width: 120,
                    //   height: 45,
                    //   color: Colors.black,
                    // ),
                    child: const Text(
                      "Your Profile",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.notifications_outlined),
                            iconSize: 28,
                          ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 13, bottom: 5),
                child: Row(
                  children: [
                    const Text(
                      "Hello , ",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13, top: 10, bottom: 10),
                child: Row(
                  children: const [
                    Text(
                      "Your orders :",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                    height: 200,
                    width: double.maxFinite,
                    child: const Orders()),
              ),
              AccountScreenOptions(),
            ],
          ),
        ));
  }
}
