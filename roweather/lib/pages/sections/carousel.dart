import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Widget> carouselDays = [
    Container(
      color: Colors.red,
      child: Center(
        child: Text('Widget 1'),
      ),
    )
  ];

  void _handleCarouselItemClick(int index){
    // implement change in day displayed
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options:CarouselOptions(
        aspectRatio: 16/9,
        autoPlay: true, 
        enlargeCenterPage:  true,
        viewportFraction: 0.8,
      ),
      items: carouselDays.map((Widget dayWidget) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                int index = carouselDays.indexOf(widget);
                _handleCarouselItemClick(index);
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: widget,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}