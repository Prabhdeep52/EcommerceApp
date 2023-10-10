// ignore_for_file: use_build_context_synchro
import 'dart:convert';
import 'dart:typed_data';

import 'package:e_commerce_app/constants/errorHandling.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:e_commerce_app/provider/userProvider.dart';
import 'package:e_commerce_app/sensitive/sense.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  // ignore: non_constant_identifier_names
  void SellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      print("step1");
      List<String> imageUrls = [];
      final clUrl =
          Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/upload");
      for (int i = 0; i < images.length; i++) {
        final request = http.MultipartRequest('POST', clUrl)
          ..fields['upload_preset'] = 'vhr13tqh'
          ..files.add(
              await http.MultipartFile.fromPath('produxtts', images[i].path));

        final response = await request.send();
        final responseData = await response.stream.toList();
        final concatenatedBytes =
            responseData.expand((bytes) => bytes).toList();
        final responseString = String.fromCharCodes(concatenatedBytes);

        final jsonMap = jsonDecode(responseString);
        final imageUrl = jsonMap['url'] as String?;
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        }
      }
      final cloudinary = CloudinaryPublic("$cloudName", "jlxtostc");

      for (int i = 0; i < images.length; i++) {
        print(i);
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product prod = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imageUrls);
      print("step 3");
      http.Response res = await http.post(Uri.parse("$uri/admin/add-product"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // 'x-auth-token': userprovider.user.token,
          },
          // body: prod.toJson(),
          body: jsonEncode(prod.toMap()));
      print("step 4");
      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')),
            );
            Navigator.pop(context);
          });
    } catch (e) {
      print("step 5");
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  //getting products

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    print("aaf");
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
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

  // delete product

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },
        body: jsonEncode({
          "id": product.id,
        }),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      print("step 5");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }
}
