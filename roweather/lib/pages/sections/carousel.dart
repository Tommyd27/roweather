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

// Stack of children to overlay flag and weather icons on each day's tile
// (using container not material to wrap list tiles)
/*
import 'package:demo/pages/sections/flag.dart';
import 'package:flutter/material.dart';

class NextDaysCarousel extends StatefulWidget {
  const NextDaysCarousel({super.key});

  @override
  State<NextDaysCarousel> createState() => _NextDaysCarouselState();
}

class _NextDaysCarouselState extends State<NextDaysCarousel> {
  int _selectedIndex = 0;
  int _flagStateIndex = 0;
  int _weatherStateIndex = 0;
  List<String> carouselDays= ['Today', 'Thu 29th', 'Fri 30th', 'Sat 1st'];
  List<AssetImage> weatherIcons = [
    const AssetImage('assets/icons/cloud-bolt-svgrepo-com.svg'),
    const AssetImage('assets/icons/cloud-showers-svgrepo-com.svg')
  ];
  List<Icon> flagIcons = [
    const Icon(Icons.flag, color: Colors.green,),
    const Icon(Icons.flag, color: Colors.yellow),
    const Icon(Icons.flag, color: Colors.red,) ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 150.0,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      itemCount: carouselDays.length,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  //color: (selectedIndex == index) ? Color(0xff85B09A) : Color(0xff003330),
                  color: const Color(0xff85B09A).withOpacity(0.30),
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  gradient: (_selectedIndex == index) ? RadialGradient(
                    colors: [const Color(0xff85B09A), Colors.grey.shade900],
                    center: Alignment.center,
                    radius: 0.99,
                    ) : null,
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
                      _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            Positioned(
              right: 10,
              top: 10,
              child: flagIcons[_flagStateIndex]
              ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ImageIcon(weatherIcons[_weatherStateIndex]))
          ],
        );
        
      } ,
    );
  }
} 
*/

// Material widget to give elevation to tiles (no icons)
/*
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
          child: Material(
            elevation: (selectedIndex == index) ? 0 : 50,
            color: (selectedIndex == index) ? Color(0xff003330).withOpacity(0.2) : Color(0xff85B09A).withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
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

*/

// Reverting to non-stack material widget version to check if it's working
/*
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
          child: Material(
            elevation: (selectedIndex == index) ? 0 : 50,
            color: (selectedIndex == index) ? Color(0xff003330).withOpacity(0.8) : Color(0xff85B09A).withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(7)),
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
*/

// Attempting again, ssack of children to overlay flag and (NON-CUSTOM) weather icons on each day's tile
// (using container not material to wrap list tiles)

import 'package:demo/pages/sections/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../appstate.dart';
import 'package:intl/intl.dart';
import '../../helper/weather.dart';

class NextDaysCarousel extends StatefulWidget {
  const NextDaysCarousel({super.key});

  @override
  State<NextDaysCarousel> createState() => _NextDaysCarouselState();
}

class CarouselElement extends StatelessWidget {
  final int index;
  final AppState appstate;

  final List<Icon> weatherIcons = [
    const Icon(Icons.sunny, color: Colors.amber),
    Icon(Icons.cloud, color: Colors.grey[400]),
  ];
  static const Map<FlagColour, Icon> flagIcons = {
    FlagColour.green: Icon(
      Icons.flag,
      color: Colors.green,
    ),
    FlagColour.yellow: Icon(Icons.flag, color: Colors.yellow),
    FlagColour.red: Icon(Icons.flag, color: Colors.red),
    FlagColour.unknown:
        Icon(Icons.flag, color: Colors.red), // TODO maybe change
  };

  static const Map<Weather, String> weatherToImage = {
    Weather.sunny: "sunny",
    Weather.partialCloudy: "partialCloudy",
    Weather.fullCloudy: "fullCloudy",
    Weather.rainy: "rainy",
  };

  CarouselElement(this.index, this.appstate, {super.key});

  @override
  Widget build(BuildContext context) {
    var outings = appstate.getOutingsForDay(appstate.daily[index].day);
    outings.sort((a, b) => a.start.hour.compareTo(b.start.hour));
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              //color: (selectedIndex == index) ? Color(0xff85B09A) : Color(0xff003330),
              color: const Color(0xff85B09A).withOpacity(0.30),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              gradient: (appstate.daySelectedIndex == index)
                  ? RadialGradient(
                      colors: [const Color(0xff85B09A), Colors.grey.shade900],
                      center: Alignment.center,
                      radius: 0.99,
                    )
                  : null,
            ),
            child: ListTile(onTap: () {
              appstate.selectDay(index);
            }),
          ),
        ),
        Positioned(
          left: 20,
          top: 10,
          child: Text(
            DateFormat("E d").format(appstate.daily[index].day),
            style: const TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: flagIcons[
                appstate.flagColour]! // TODO: Change to flag colour prediction
            ),
        Positioned(
          left: 10, // adjust as needed
          top: 40, // adjust as needed
          child: Align(
            alignment: Alignment.topCenter,
            child: outings.isNotEmpty
                ? Column(
                    children: outings.take(2).map((outing) {
                      return Container(
                        padding: EdgeInsets.all(1.0),
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Color(0xffEFD9CE),
                          border: Border.all(color: Color(0xffEFD9CE)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${outing.start.hour} - ${outing.end.hour} Outing',
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      );
                    }).toList(),
                  )
                : Container(),
          ),
        ),
        Positioned(
            right: -5,
            bottom: -5,
            child: Image(
                image: AssetImage(
                    'assets/icons/${weatherToImage[appstate.daily[index].weather]}.png'),
                width: 70))
      ],
    );
  }
}

class _NextDaysCarouselState extends State<NextDaysCarousel> {
  @override
  Widget build(BuildContext context) => Consumer<AppState>(
      builder: (context, appstate, child) => ListView.builder(
            itemExtent: 150.0,
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            itemCount: appstate.daily.length,
            itemBuilder: (BuildContext context, int index) =>
                CarouselElement(index, appstate),
          ));
}
