import 'package:e_commerce_app/constants/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CorouselImage extends StatelessWidget {
  const CorouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVariables.carouselImages.map((e) {
          return Builder(
              builder: ((BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  )));
        }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 210,
        ));
  }
}
