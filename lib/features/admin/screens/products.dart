import 'package:e_commerce_app/features/admin/screens/addProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void NavigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Products"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: NavigateToAddProduct,
        tooltip: "Add a product",
        child: Icon(
          Icons.add,
          color: Colors.amber[600],
        ),
      ),
    );
  }
}
