import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/constants/errorHandling.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/sensitive/sense.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchProductWithCategory(
      {required BuildContext context, required String category}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token': userprovider.user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            print("succ");
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: ${err.toString()}')));
    }
    return productList;
  }
}
