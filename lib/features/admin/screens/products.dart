import 'package:e_commerce_app/features/accounts/widgets/singleProduct.dart';
import 'package:e_commerce_app/features/admin/screens/addProductScreen.dart';
import 'package:e_commerce_app/features/admin/services/adminServices.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products;
  final AdminServices adminservices = AdminServices();

  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  void deleteProduct(Product product, int index) {
    adminservices.deleteProduct(
        context: context,
        product: product,
        onSuccess: () {
          products!.removeAt(index);
          setState(() {});
        });
  }

  getAllProducts() async {
    List<Product>? products1 = await adminservices.fetchAllProducts(context);
    setState(() {
      products = products1;
    });
  }

  // ignore: non_constant_identifier_names
  void NavigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
            onPressed: NavigateToAddProduct,
            tooltip: "Add a product",
            child: Icon(
              Icons.add,
              color: Colors.amber[600],
            ),
          ))
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(image: productData.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                          IconButton(
                              onPressed: () =>
                                  deleteProduct(productData, index),
                              icon: const Icon(Icons.delete))
                        ],
                      )
                    ],
                  );
                }),
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
