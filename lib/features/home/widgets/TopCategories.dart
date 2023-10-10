import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:e_commerce_app/features/home/categoriesDealsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  void NavigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 90,
        width: double.maxFinite,
        // width: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => NavigateToCategoryPage(
                  context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      // vertical: 4,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 60,
                        width: 60,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            );
          },
        ));
  }
}
