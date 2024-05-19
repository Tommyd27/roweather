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

/*
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
} */

/*
import 'package:flutter/material.dart';

class NextDaysCarousel extends StatefulWidget {
  const NextDaysCarousel({super.key});

  @override
  State<NextDaysCarousel> createState() => _NextDaysCarouselState();
}

class _NextDaysCarouselState extends State<NextDaysCarousel> {
  List<String> carouselDays= ['Today', 'Tomorrow', '3rd day', '4th day'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 150.0,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: carouselDays.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: ListTile(
            selected: false,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7))),
            tileColor:  Color(0xff85B09A),
            selectedTileColor: Color(0xff003330),
            title: Text(carouselDays[index]),
            onTap: (){
              setState(() {
              });
            },
          ),
        );
      } ,
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
  int selectedIndex = 0;
  List<String> carouselDays= ['Today', 'Thu 29th', 'Fri 30th', 'Sat 1st'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 150.0,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: carouselDays.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: (selectedIndex == index) ? Color(0xff85B09A) : Color(0xff003330),
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            child: ListTile(
              title: Text(
                carouselDays[index],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
                ),
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        );
      } ,
    );
  }
} 