import 'package:e_commerce_app/features/accounts/widgets/optionsTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AccountScreenOptions extends StatefulWidget {
  const AccountScreenOptions({super.key});

  @override
  State<AccountScreenOptions> createState() => _AccountScreenOptionsState();
}

class _AccountScreenOptionsState extends State<AccountScreenOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        optionsTile(
            icon: Icons.shopping_bag_outlined,
            topText: "Orders",
            bottomText: "Check your order status"),
        optionsTile(
            icon: Icons.star_border_outlined,
            topText: "Suggestions",
            bottomText: "Get expert Suggestions "),
        optionsTile(
            icon: Icons.help_center_outlined,
            topText: "Help Centre",
            bottomText: "Help with your purchases "),
        optionsTile(
            icon: Icons.air_outlined,
            topText: "Insiders",
            bottomText: "Coupons, offers and more"),
        optionsTile(
            icon: Icons.wallet_giftcard_sharp,
            topText: "Wishlist",
            bottomText: "Your most loved items")
      ],
    );
  }
}
