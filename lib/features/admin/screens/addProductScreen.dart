// ignore: file_names
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:dotted_border/dotted_border.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product-screen";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  String category = "Mobiles";
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  void addImages() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt! <= 32) {
        /// use [Permissions.storage.status]
        var status = await Permission.storage.request();
        if (status.isGranted) {
          var result = await pickImages();
          setState(() {
            images = result;
          });
        }
      } else {
        /// use [Permissions.photos.status]
        var status = await Permission.photos.request();
        if (status.isGranted) {
          var result = await pickImages();
          setState(() {
            images = result;
          });
        }
      }
    }

    // if (await Permission.storage.request().isGranted) {
    // Either the permission was already granted before or the user just granted it.

    // }
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
            title: Container(
              alignment: Alignment.center,
              child: const Text(
                "Add Products ",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map((e) {
                        return Builder(
                            builder: ((BuildContext context) => Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                )));
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 210,
                      ))
                  : GestureDetector(
                      onTap: addImages,
                      child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_outlined,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Select Product images",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          )),
                    ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                controller: productNameController,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Product Name",
                  hintText: "Enter your product name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                controller: descriptionController,
                autocorrect: false,
                maxLines: 6,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Description",
                  hintText: "Enter the description of the product ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                controller: priceController,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Price",
                  hintText: "Enter the price of the product",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextFormField(
                controller: quantityController,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Quantity",
                  hintText: "Enter the quantity of available product",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(350, 40)),
                    shape: MaterialStateProperty.all(
                      const ContinuousRectangleBorder(
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(13),
                        ),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 48, 130, 201),
                    ),
                  ),
                  child: const Text(
                    "Sell",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
