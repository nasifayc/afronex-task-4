import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselSliderAnimation extends StatelessWidget {
  CarouselSliderAnimation({super.key});

  final List<String> images = [
    'asset/images/image2.jpg',
    'asset/images/image1.jpg',
    'asset/images/image3.jpg',
    'asset/images/image4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeFactor: 10,
        disableCenter: true,
        aspectRatio: 16 / 6,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: images.map((String url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: Colors.blueGrey,
                  image: DecorationImage(
                      image: AssetImage(url), fit: BoxFit.cover)),
            );
          },
        );
      }).toList(),
    );
  }
}
