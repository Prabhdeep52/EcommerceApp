import 'package:e_commerce_app/features/home/services/HomeServices.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchCategoryProduct();
  }

  fetchCategoryProduct() async {
    productList = await homeServices.fetchProductWithCategory(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 246, 246, 246)
                  // gradient: GlobalVariables.appBarGradient
                  ),
        ),
        title: Text(
          widget.category,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      body: productList == null
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(10),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Image.network(product.images[0]),
                            ),
                          ),
                          // Text("${productList![index]}")
                          Container(
                            width: 200,
                            // alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ]),
            ),
    );
  }
}
