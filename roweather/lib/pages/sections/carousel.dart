/* import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Widget> carouselDays = [
    Container(
      color: Color(0xff85B09A),
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
                int index = carouselDays.indexOf(dayWidget);
                _handleCarouselItemClick(index);
              },
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: dayWidget,
              ),
            );
          },
        );
      }).toList(),
    );
  }
} */

import 'package:flutter/material.dart';

class NextDaysCarousel extends StatefulWidget {
  const NextDaysCarousel({super.key});

  @override
  State<NextDaysCarousel> createState() => _NextDaysCarouselState();
}

class _NextDaysCarouselState extends State<NextDaysCarousel> {
  List<String> carouselDays= ['Today', 'Tomorrow'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 20.0,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: carouselDays.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(carouselDays[index]),
          onTap: (){},
          tileColor: Color(0xff85B09A)
        );
      } ,
      
    );
  }
}